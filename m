Return-Path: <mala@hinterbergen.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 7ACF568110
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Sep 2005 20:21:36 +1000 (EST)
Received: from ws02.hinter.bergen (ws02.hinter.bergen [192.168.42.12])
	by router.hinter.bergen (Postfix) with ESMTP id 918351142FB
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Sep 2005 10:21:30 +0000 (UTC)
Received: from ws02.hinter.bergen ([127.0.0.1])
	by ws02.hinter.bergen with esmtp (Exim 3.36 #1 (Debian))
	id 1EBV9O-0000fx-00
	for <linuxppc-dev@ozlabs.org>; Sat, 03 Sep 2005 10:21:30 +0000
Message-ID: <43197929.1060906@hinterbergen.de>
Date: Sat, 03 Sep 2005 10:21:29 +0000
From: Manuel Tobias Schiller <mala@hinterbergen.de>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/mixed; boundary="------------010307080706070006030106"
Subject: [PATCH] Re: Strange behaviour of adjtimex/settimeofday syscalls
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------010307080706070006030106
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all,

I'm running Linux 2.4.31 on a G3. I usually synchronize the clocks on my
LAN using ntpd. Inspecting the kernel with the ntptime utility yields an
error exit code from ntp_adjtime() which won't clear for weeks (i.e. the
output line looks like this:

	...
	ntp_adjtime() returns code 5 (ERROR)
	...

The members of the structure representing the kernel time PLL status etc
all look reasonable, and clock synchronisation using ntpd works quite
well - that's why I think there may be something wrong with the kernel
setting this error condition.)

Looking through the kernel source, I found that the ppc version of
do_settimeofday sets an error variable without clearing it anywhere.
Since other architectures don't do that, I applied the patch below to
avoid setting the error state.

I've been running with the modified kernel for almost a month now
without problems, so I think this patch might be interesting for the
general public (I haven't found anything similar with google). I'd like
to know what you think of it. If you think it's ok, it would be nice of
you if someone could make sure the patch makes it into mainstream
kernels. (The likelihood of the patch making it into the mainstream
kernels is just higher if more people have looked over it, so that's why
I'm posting it here, hoping for people that have more knowledge of these
things than I and are willing to test it).

Many thanks for your consideration.

Manuel Schiller


P.S. I've just noticed that the web interface doesn't handle the PGP
signatures of my previous submission well, so I'm resending the mail
without it. I'm terribly sorry for the inconvenience.

--------------010307080706070006030106
Content-Type: video/x-dv;
 name="ppc-settimeofday.dif"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="ppc-settimeofday.dif"

LS0tIGFyY2gvcHBjL2tlcm5lbC90aW1lLmMJMjAwNS0wNi0wNCAyMzoxMDoyNy4wMDAwMDAw
MDAgKzAwMDAKKysrIGFyY2gvcHBjL2tlcm5lbC90aW1lLmMJMjAwNS0wOC0wOCAyMDo1Nzow
OS4wMDAwMDAwMDAgKzAwMDAKQEAgLTQwLDYgKzQwLDkgQEAKICAqCiAgKiAxOTk3LTA5LTEw
ICBVcGRhdGVkIE5UUCBjb2RlIGFjY29yZGluZyB0byB0ZWNobmljYWwgbWVtb3JhbmR1bSBK
YW4gJzk2CiAgKiAgICAgICAgICAgICAiQSBLZXJuZWwgTW9kZWwgZm9yIFByZWNpc2lvbiBU
aW1la2VlcGluZyIgYnkgRGF2ZSBNaWxscworICogMjAwNS0wOC0wOCAgVXBkYXRlZCBkb19z
ZXR0aW1lb2ZkYXkgbm90IHRvIHNldCB0aW1lX3N0YXRlIHRvIFRJTUVfRVJST1IKKyAqICAg
ICAgICAgICAgIG90aGVyIGFyY2hpdGVjdHVyZXMgZG9uJ3QgZG8gaXQgZWl0aGVyaTsgdGhp
cyBtYWtlcyBhZGp0aW1leAorICogICAgICAgICAgICAgcmV0dXJuIE9LIGluc3RlYWQgb2Yg
RVJST1IgKE0uIFNjaGlsbGVyLCBtYWxhQGhpbnRlcmJlcmdlbi5kZSkKICAqLwogCiAjaW5j
bHVkZSA8bGludXgvY29uZmlnLmg+CkBAIC0yODQsNyArMjg3LDkgQEAKIAogCXRpbWVfYWRq
dXN0ID0gMDsgICAgICAgICAgICAgICAgLyogc3RvcCBhY3RpdmUgYWRqdGltZSgpICovCiAJ
dGltZV9zdGF0dXMgfD0gU1RBX1VOU1lOQzsKLQl0aW1lX3N0YXRlID0gVElNRV9FUlJPUjsg
ICAgICAgIC8qIHAuIDI0LCAoYSkgKi8KKwkvKiBJIHRoaW5rIHRoZSBmb2xsb3dpbmcgbGlu
ZSBzaG91bGQgYmUgY29tbWVudGVkIG91dCwgb3RoZXIKKwkgKiBhcmNoaXRlY3R1cmVzIGRv
bid0IG1vZGlmeSB0aW1lX3N0YXRlIGhlcmUgLSAwOC8wOC8wNSBNLiBTY2hpbGxlciAqLwor
CS8qIHRpbWVfc3RhdGUgPSBUSU1FX0VSUk9SOyAqLyAgICAgICAgLyogcC4gMjQsIChhKSAq
LwogCXRpbWVfbWF4ZXJyb3IgPSBOVFBfUEhBU0VfTElNSVQ7CiAJdGltZV9lc3RlcnJvciA9
IE5UUF9QSEFTRV9MSU1JVDsKIAl3cml0ZV91bmxvY2tfaXJxcmVzdG9yZSgmeHRpbWVfbG9j
aywgZmxhZ3MpOwo=
--------------010307080706070006030106--
