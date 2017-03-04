Return-Path: <mhiramat@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.136])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vZtVg5lVMzDqGq
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Mar 2017 15:34:18 +1100 (AEDT)
Date: Sat, 4 Mar 2017 13:34:05 +0900
From: Masami Hiramatsu <mhiramat@kernel.org>
To: Masami Hiramatsu <mhiramat@kernel.org>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>, Arnaldo Carvalho de
 Melo <acme@kernel.org>, Steven Rostedt <rostedt@goodmis.org>, Ingo Molnar
 <mingo@redhat.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Ananth N Mavinakayanahalli
 <ananth@linux.vnet.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH v4 2/3] perf: kretprobes: offset from reloc_sym if
 kernel supports it
Message-Id: <20170304133405.176da43d40cec7cb00e757e1@kernel.org>
In-Reply-To: <20170304113551.6a008b969a3ed713729cbd57@kernel.org>
References: <cover.1488475783.git.naveen.n.rao@linux.vnet.ibm.com>
 <fd619418f5967ca7a77e5c1b49e632862040703b.1488475783.git.naveen.n.rao@linux.vnet.ibm.com>
 <20170304094911.5f96a10a9f075b6f16fe90d3@kernel.org>
 <20170304113551.6a008b969a3ed713729cbd57@kernel.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Sat__4_Mar_2017_13_34_05_+0900_CrDo7cVjNk45.SrS"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

--Multipart=_Sat__4_Mar_2017_13_34_05_+0900_CrDo7cVjNk45.SrS
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 4 Mar 2017 11:35:51 +0900
Masami Hiramatsu <mhiramat@kernel.org> wrote:

> On Sat, 4 Mar 2017 09:49:11 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > On Thu,  2 Mar 2017 23:25:06 +0530
> > "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com> wrote:
> > 
> > > We indicate support for accepting sym+offset with kretprobes through a
> > > line in ftrace README. Parse the same to identify support and choose the
> > > appropriate format for kprobe_events.
> > 
> > Could you give us an example of this change here? :)
> > for example, comment of commit 613f050d68a8 .
> > 
> > I think the code is OK, but we need actual example of result.
> 
> Hi Naveen,
> 
> I've tried following commands
> 
> $ grep "[Tt] user_read$" /proc/kallsyms  
> 0000000000000000 T user_read
> 0000000000000000 t user_read
> $ sudo ./perf probe -D user_read%return
> r:probe/user_read _text+3539616
> r:probe/user_read_1 _text+3653408
> 
> OK, looks good. However, when I set the retprobes, I got an error.
> 
> $ sudo ./perf probe -a user_read%return
> Failed to write event: Invalid argument
>   Error: Failed to add events.
> 
> And kernel rejected that.
> 
> $ dmesg -k | tail -n 1
> [  850.315068] Given offset is not valid for return probe.
> 
> Hmm, curious..

Ah, I see.

static int create_trace_kprobe(int argc, char **argv)
...
        } else {
                /* a symbol specified */
                symbol = argv[1];
                /* TODO: support .init module functions */
                ret = traceprobe_split_symbol_offset(symbol, &offset);
                if (ret) {
                        pr_info("Failed to parse symbol.\n");
                        return ret;
                }
                if (offset && is_return &&
                    !arch_function_offset_within_entry(offset)) {
                        pr_info("Given offset is not valid for return probe.\n");
                        return -EINVAL;
                }
        }

So, actually, traceprobe_split_symbol_offset() just split out symbol
and offset from symbol string (e.g. "_text+3539616").
So, you should use kallsyms_lookup_size_offset() here again to check
offset.

Please try attached patch (I've already tested on x86-64).

$ sudo ./perf probe -a user_read%return
Added new events:
  probe:user_read      (on user_read%return)
  probe:user_read_1    (on user_read%return)

You can now use it in all perf tools, such as:

	perf record -e probe:user_read_1 -aR sleep 1

$ sudo ./perf probe -l
  probe:user_read      (on user_read%return@security/keys/user_defined.c)
  probe:user_read_1    (on user_read%return@selinux/ss/policydb.c)
$ sudo cat /sys/kernel/debug/kprobes/list
ffffffff9637bf70  r  user_read+0x0    [DISABLED][FTRACE]
ffffffff963602f0  r  user_read+0x0    [DISABLED][FTRACE]

Thank you,


-- 
Masami Hiramatsu <mhiramat@kernel.org>

--Multipart=_Sat__4_Mar_2017_13_34_05_+0900_CrDo7cVjNk45.SrS
Content-Type: application/octet-stream;
 name="tracing-kprobe-check-kretprobe"
Content-Disposition: attachment;
 filename="tracing-kprobe-check-kretprobe"
Content-Transfer-Encoding: base64

dHJhY2luZzoga3Byb2JlOiBDaGVjayBrcmV0cHJvYmUgb2Zmc2V0IGZyb20gc3ltYm9sIGNvcnJl
Y3RseQoKRnJvbTogTWFzYW1pIEhpcmFtYXRzdSA8bWhpcmFtYXRAa2VybmVsLm9yZz4KCkNoZWNr
IHRoZSBrcmV0cHJvYmUgZXZlbnQgb2Zmc2V0IGZyb20gdGhlIG5lYXJlc3Qgc3ltYm9sIGNvcnJl
Y3RseQppbnN0ZWFkIG9mIGNoZWNraW5nIGdpdmVuIG9mZnNldCB2YWx1ZS4KVGhpcyB3aWxsIGFs
bG93IHVzZXJzIHRvIHNwZWNpZnkgdGhlIHJlbGF0aXZlIG9mZnNldCBmcm9tIF90ZXh0Cm9yIF9z
dGV4dCBzbyB0aGF0IHRoZXkgY2FuIHB1dCBhIGtyZXRwcm9iZSBvbiBvbmUgb2Ygc2FtZS1uYW1l
CmZ1bmN0aW9ucy4KClNpZ25lZC1vZmYtYnk6IE1hc2FtaSBIaXJhbWF0c3UgPG1oaXJhbWF0QGtl
cm5lbC5vcmc+Ci0tLQogaW5jbHVkZS9saW51eC9rcHJvYmVzLmggICAgIHwgICAgOSArKysrKysr
KysKIGtlcm5lbC9rcHJvYmVzLmMgICAgICAgICAgICB8ICAgIDkgLS0tLS0tLS0tCiBrZXJuZWwv
dHJhY2UvdHJhY2Vfa3Byb2JlLmMgfCAgIDE4ICsrKysrKysrKysrKysrKysrLQogMyBmaWxlcyBj
aGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L2twcm9iZXMuaCBiL2luY2x1ZGUvbGludXgva3Byb2Jlcy5oCmluZGV4IDg2
MmY4N2EuLjZhOTI3MzQgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUvbGludXgva3Byb2Jlcy5oCisrKyBi
L2luY2x1ZGUvbGludXgva3Byb2Jlcy5oCkBAIC00NCw2ICs0NCwxNSBAQAogI2lmZGVmIENPTkZJ
R19LUFJPQkVTCiAjaW5jbHVkZSA8YXNtL2twcm9iZXMuaD4KIAorLyoKKyAqIFNvbWUgb2RkYmFs
bCBhcmNoaXRlY3R1cmVzIGxpa2UgNjRiaXQgcG93ZXJwYyBoYXZlIGZ1bmN0aW9uIGRlc2NyaXB0
b3JzCisgKiBzbyB0aGlzIG11c3QgYmUgb3ZlcnJpZGFibGUuCisgKi8KKyNpZm5kZWYga3Byb2Jl
X2xvb2t1cF9uYW1lCisjZGVmaW5lIGtwcm9iZV9sb29rdXBfbmFtZShuYW1lLCBhZGRyKSBcCisJ
YWRkciA9ICgoa3Byb2JlX29wY29kZV90ICopKGthbGxzeW1zX2xvb2t1cF9uYW1lKG5hbWUpKSkK
KyNlbmRpZgorCiAvKiBrcHJvYmVfc3RhdHVzIHNldHRpbmdzICovCiAjZGVmaW5lIEtQUk9CRV9I
SVRfQUNUSVZFCTB4MDAwMDAwMDEKICNkZWZpbmUgS1BST0JFX0hJVF9TUwkJMHgwMDAwMDAwMgpk
aWZmIC0tZ2l0IGEva2VybmVsL2twcm9iZXMuYyBiL2tlcm5lbC9rcHJvYmVzLmMKaW5kZXggYTc3
ZjlkNy4uOTIzNmYzZiAxMDA2NDQKLS0tIGEva2VybmVsL2twcm9iZXMuYworKysgYi9rZXJuZWwv
a3Byb2Jlcy5jCkBAIC01OCwxNSArNTgsNiBAQAogI2RlZmluZSBLUFJPQkVfVEFCTEVfU0laRSAo
MSA8PCBLUFJPQkVfSEFTSF9CSVRTKQogCiAKLS8qCi0gKiBTb21lIG9kZGJhbGwgYXJjaGl0ZWN0
dXJlcyBsaWtlIDY0Yml0IHBvd2VycGMgaGF2ZSBmdW5jdGlvbiBkZXNjcmlwdG9ycwotICogc28g
dGhpcyBtdXN0IGJlIG92ZXJyaWRhYmxlLgotICovCi0jaWZuZGVmIGtwcm9iZV9sb29rdXBfbmFt
ZQotI2RlZmluZSBrcHJvYmVfbG9va3VwX25hbWUobmFtZSwgYWRkcikgXAotCWFkZHIgPSAoKGtw
cm9iZV9vcGNvZGVfdCAqKShrYWxsc3ltc19sb29rdXBfbmFtZShuYW1lKSkpCi0jZW5kaWYKLQog
c3RhdGljIGludCBrcHJvYmVzX2luaXRpYWxpemVkOwogc3RhdGljIHN0cnVjdCBobGlzdF9oZWFk
IGtwcm9iZV90YWJsZVtLUFJPQkVfVEFCTEVfU0laRV07CiBzdGF0aWMgc3RydWN0IGhsaXN0X2hl
YWQga3JldHByb2JlX2luc3RfdGFibGVbS1BST0JFX1RBQkxFX1NJWkVdOwpkaWZmIC0tZ2l0IGEv
a2VybmVsL3RyYWNlL3RyYWNlX2twcm9iZS5jIGIva2VybmVsL3RyYWNlL3RyYWNlX2twcm9iZS5j
CmluZGV4IGM2MGY5ZGMuLjU5ZjJiMmYgMTAwNjQ0Ci0tLSBhL2tlcm5lbC90cmFjZS90cmFjZV9r
cHJvYmUuYworKysgYi9rZXJuZWwvdHJhY2UvdHJhY2Vfa3Byb2JlLmMKQEAgLTU4Nyw2ICs1ODcs
MjIgQEAgc3RhdGljIGludCB0cmFjZV9rcHJvYmVfbW9kdWxlX2NhbGxiYWNrKHN0cnVjdCBub3Rp
Zmllcl9ibG9jayAqbmIsCiAJcmV0dXJuIE5PVElGWV9ET05FOwogfQogCitzdGF0aWMgYm9vbCBm
dW5jdGlvbl9vZmZzZXRfd2l0aGluX2VudHJ5KGNvbnN0IGNoYXIgKnN5bSwgdW5zaWduZWQgbG9u
ZyBvZmZzKQoreworCXZvaWQgKmFkZHIgPSBOVUxMOworCisJa3Byb2JlX2xvb2t1cF9uYW1lKHN5
bSwgYWRkcik7CisJaWYgKCFhZGRyKQorCQlyZXR1cm4gZmFsc2U7CisJYWRkciArPSBvZmZzOwor
CisJaWYgKGthbGxzeW1zX2xvb2t1cF9zaXplX29mZnNldCgodW5zaWduZWQgbG9uZylhZGRyLCBO
VUxMLCAmb2ZmcykgJiYKKwkgICAgb2ZmcyA9PSAwKQorCQlyZXR1cm4gdHJ1ZTsKKworCXJldHVy
biBmYWxzZTsKK30KKwogc3RhdGljIHN0cnVjdCBub3RpZmllcl9ibG9jayB0cmFjZV9rcHJvYmVf
bW9kdWxlX25iID0gewogCS5ub3RpZmllcl9jYWxsID0gdHJhY2Vfa3Byb2JlX21vZHVsZV9jYWxs
YmFjaywKIAkucHJpb3JpdHkgPSAxCS8qIEludm9rZWQgYWZ0ZXIga3Byb2JlIG1vZHVsZSBjYWxs
YmFjayAqLwpAQCAtNjk1LDcgKzcxMSw3IEBAIHN0YXRpYyBpbnQgY3JlYXRlX3RyYWNlX2twcm9i
ZShpbnQgYXJnYywgY2hhciAqKmFyZ3YpCiAJCQlyZXR1cm4gcmV0OwogCQl9CiAJCWlmIChvZmZz
ZXQgJiYgaXNfcmV0dXJuICYmCi0JCSAgICAhYXJjaF9mdW5jdGlvbl9vZmZzZXRfd2l0aGluX2Vu
dHJ5KG9mZnNldCkpIHsKKwkJICAgICFmdW5jdGlvbl9vZmZzZXRfd2l0aGluX2VudHJ5KHN5bWJv
bCwgb2Zmc2V0KSkgewogCQkJcHJfaW5mbygiR2l2ZW4gb2Zmc2V0IGlzIG5vdCB2YWxpZCBmb3Ig
cmV0dXJuIHByb2JlLlxuIik7CiAJCQlyZXR1cm4gLUVJTlZBTDsKIAkJfQo=

--Multipart=_Sat__4_Mar_2017_13_34_05_+0900_CrDo7cVjNk45.SrS--
