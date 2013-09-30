Return-Path: <linus971@gmail.com>
Received: from mail-ve0-x231.google.com (mail-ve0-x231.google.com
 [IPv6:2607:f8b0:400c:c01::231])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D0CDC2C0098
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 05:29:48 +1000 (EST)
Received: by mail-ve0-f177.google.com with SMTP id db12so4391300veb.22
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Sep 2013 12:29:45 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
Date: Mon, 30 Sep 2013 12:29:44 -0700
Message-ID: <CA+55aFwp-RAKEMVvbMG53C=kTMqS09NPXy1eP4xEUYZpvV8X5Q@mail.gmail.com>
Subject: Avoiding the dentry d_lock on final dput(),
 part deux: transactional memory
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Ingo Molnar <mingo@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 Waiman Long <Waiman.Long@hp.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: multipart/mixed; boundary=20cf307f3170c458a104e79edba3
Cc: "Norton, Scott J" <scott.norton@hp.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Chandramouleeswaran,
 Aswin" <aswin@hp.com>, George Spelvin <linux@horizon.com>,
 linux-fsdevel <linux-fsdevel@vger.kernel.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--20cf307f3170c458a104e79edba3
Content-Type: text/plain; charset=UTF-8

So with all the lockref work, we now avoid the dentry d_lock for
almost all normal cases.

There is one single remaining common case, though: the final dput()
when the dentry count goes down to zero, and we need to check if we
are supposed to get rid of the dentry (or at least put it on the LRU
lists etc).

And that's something lockref itself cannot really help us with unless
we start adding status bits to it (eg some kind of "enable slow-case"
bit in the lock part of the lockref). Which sounds like a clever but
very fragile approach.

However, I did get myself a i7-4770S exactly because I was
forward-thinking, and wanted to try using transactional memory for
these kinds of things.

Quite frankly, from all I've seen so far, the kernel is not going to
have very good luck with things like lock elision, because we're
really fine-grained already, and at least the Intel lock-elision
(don't know about POWER8) basically requires software to do prediction
on whether the transaction will succeed or not, dynamically based on
aborts etc. And quite frankly, by the time you have to do things like
that, you've already lost. We're better off just using our normal
locks.

So as far as I'm concerned, transactional memory is going to be useful
- *if* it is useful - only for specialized code. Some of that might be
architecture-internal lock implementations, other things might be
exactly the dput() kind of situation.

And the thing is, *normally* dput() doesn't need to do anything at
all, except decrement the dentry reference count. However, for that
normal case to be true, we need to atomically check:

 - that the dentry lock isn't held (same as lockref)
 - that we are already on the LRU list and don't need to add ourselves to it
 - that we already have the DCACHE_REFERENCED bit set and don't need to set it
 - that the dentry isn't unhashed and needs to be killed.

Additionally, we need to check that it's not a dentry that has a
"d_delete()" operation, but that's a static attribute of a dentry, so
that's not something that we need to check atomically wrt the other
things.

ANYWAY. With all that out of the way, the basic point is that this is
really simple, and fits very well with even very limited transactional
memory. We literally need to do just a single write, and something
like three reads from memory. And we already have a trivial fallback,
namely the old code using the lockrefs.  IOW, it's literally ten
straight-line instructions between the xbegin and the xend for me.

So here's a patch that works for me. It requires gcc to know "asm
goto", and it requires binutils that know about xbegin/xabort. And it
requires a CPU that supports the intel RTM extensions.

But I'm cc'ing the POWER people, because I don't know the POWER8
interfaces, and I don't want to necessarily call this "xbegin"/"xend"
when I actually wrap it in some helper functions.

Anyway, profiles with this look beautiful (I'm using "make -j" on a
fully built allmodconfig kernel tree as the source of profile data).
There's no spinlocks from dput at all, and the dput() profile itself
shows basically 1% in anything but the fastpath (probably the _very_
occasional first accesses where we need to add things to the LRU
lists).

And the patch is small, but is obviously totally lacking any test for
CPU support or anything like that. Or portability. But I thought I'd
get the ball rolling, because I doubt the intel TSX patches are going
to be useful (if they were, Intel would be crowing about performance
numbers now that the CPU's are out, and they aren't).

I don't know if the people doing HP performance testing have
TSX-enabled machines, but hey, maybe. So you guys are cc'd too.

I also didn't actually check if performance is affected. I doubt it is
measurable on this machine, especially on "make -j" that spends 90% of
its time in user space. But the profile comparison really does make it
look good..

Comments?

                         Linus

--20cf307f3170c458a104e79edba3
Content-Type: application/octet-stream; name="patch.diff"
Content-Disposition: attachment; filename="patch.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hm83d39n0

IGZzL2RjYWNoZS5jIHwgMzIgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKIDEgZmls
ZSBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvZnMvZGNhY2hlLmMgYi9m
cy9kY2FjaGUuYwppbmRleCA0MTAwMDMwNWQ3MTYuLmM5ODg4MDZiOTQxZSAxMDA2NDQKLS0tIGEv
ZnMvZGNhY2hlLmMKKysrIGIvZnMvZGNhY2hlLmMKQEAgLTYwMyw2ICs2MDMsOSBAQCByZWxvY2s6
CiAgKiBSZWFsIHJlY3Vyc2lvbiB3b3VsZCBlYXQgdXAgb3VyIHN0YWNrIHNwYWNlLgogICovCiAK
KyNkZWZpbmUgaXNfc2ltcGxlX2RwdXQoZGVudHJ5KSBcCisJKCgoZGVudHJ5KS0+ZF9mbGFncyAm
IChEQ0FDSEVfUkVGRVJFTkNFRCB8RENBQ0hFX0xSVV9MSVNUKSkgPT0gKERDQUNIRV9SRUZFUkVO
Q0VEIHxEQ0FDSEVfTFJVX0xJU1QpKQorCiAvKgogICogZHB1dCAtIHJlbGVhc2UgYSBkZW50cnkK
ICAqIEBkZW50cnk6IGRlbnRyeSB0byByZWxlYXNlIApAQCAtNjE3LDYgKzYyMCwzNSBAQCB2b2lk
IGRwdXQoc3RydWN0IGRlbnRyeSAqZGVudHJ5KQogCWlmICh1bmxpa2VseSghZGVudHJ5KSkKIAkJ
cmV0dXJuOwogCisJLyoKKwkgKiBUcnkgUlRNIGZvciB0aGUgdHJpdmlhbCAtIGFuZCBjb21tb24g
LSBjYXNlLgorCSAqCisJICogV2UgZG9uJ3QgZG8gdGhpcyBmb3IgRENBQ0hFX09QX0RFTEVURSAo
d2hpY2ggaXMgYSBzdGF0aWMgZmxhZywKKwkgKiBzbyBjaGVjayBpdCBvdXRzaWRlIHRoZSB0cmFu
c2FjdGlvbiksIGFuZCB3ZSByZXF1aXJlIHRoYXQgdGhlCisJICogZGVudHJ5IGlzIGFscmVhZHkg
bWFya2VkIHJlZmVyZW5jZWQgYW5kIG9uIHRoZSBMUlUgbGlzdC4KKwkgKgorCSAqIElmIHRoYXQg
aXMgdHJ1ZSwgYW5kIHRoZSBkZW50cnkgaXMgbm90IGxvY2tlZCwgd2UgY2FuIGp1c3QKKwkgKiBk
ZWNyZW1lbnQgdGhlIHVzYWdlIGNvdW50LgorCSAqCisJICogVGhpcyBpcyBraW5kIG9mIGEgc3Bl
Y2lhbCBzdXBlci1jYXNlIG9mIGxvY2tyZWZfcHV0KCksIGJ1dAorCSAqIGF0b21pY2FsbHkgdGVz
dGluZyB0aGUgZGVudHJ5IGZsYWdzIHRvIG1ha2Ugc3VyZSB0aGF0IHRoZXJlCisJICogaXMgbm90
aGluZyBlbHNlIHdlIG5lZWQgdG8gbG9vayBhdC4KKwkgKi8KKwlpZiAodW5saWtlbHkoZGVudHJ5
LT5kX2ZsYWdzICYgRENBQ0hFX09QX0RFTEVURSkpCisJCWdvdG8gcmVwZWF0OworCWFzbSBnb3Rv
KCJ4YmVnaW4gJWxbcmVwZWF0XSI6IDogOiJtZW1vcnkiLCJheCI6cmVwZWF0KTsKKwlpZiAodW5s
aWtlbHkoZF91bmhhc2hlZChkZW50cnkpKSkKKwkJZ290byB4YWJvcnQ7CisJaWYgKHVubGlrZWx5
KCFpc19zaW1wbGVfZHB1dChkZW50cnkpKSkKKwkJZ290byB4YWJvcnQ7CisJaWYgKHVubGlrZWx5
KCFhcmNoX3NwaW5fdmFsdWVfdW5sb2NrZWQoZGVudHJ5LT5kX2xvY2sucmxvY2sucmF3X2xvY2sp
KSkKKwkJZ290byB4YWJvcnQ7CisJZGVudHJ5LT5kX2xvY2tyZWYuY291bnQtLTsKKwlhc20gdm9s
YXRpbGUoInhlbmQiKTsKKwlyZXR1cm47CisKK3hhYm9ydDoKKwlhc20gdm9sYXRpbGUoInhhYm9y
dCAkMCIpOwogcmVwZWF0OgogCWlmIChsb2NrcmVmX3B1dF9vcl9sb2NrKCZkZW50cnktPmRfbG9j
a3JlZikpCiAJCXJldHVybjsK
--20cf307f3170c458a104e79edba3--
