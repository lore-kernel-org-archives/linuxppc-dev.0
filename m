From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
To: Paul Mackerras <paulus@cs.anu.edu.au>, brad@pht.com
Subject: Re: 601 vs head.S
Date: Sun, 21 Feb 1999 22:13:53 +0100
Content-Type: Multipart/Mixed;
  boundary="Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD"
Cc: linuxppc-dev@lists.linuxppc.org
References: <199902211059.VAA01518@tango.anu.edu.au>
MIME-Version: 1.0
Message-Id: <99022122261100.00321@ns1102.munich.netsurf.de>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

Am Sun, 21 Feb 1999 schrieb Paul Mackerras:
>Brad Midgley <brad@pht.com> wrote:
>
>> my quest is for a kernel that boots both on the 7200 and the imac. help me
>
>Found it... had to take out the 2 nop's in hash_page this time.  Vger
>(cvs) and samba (rsync) have the fix, if you want a precompiled
>kernel, try ftp://ftp.linuxppc.org/linuxppc/kernel/powermac/test/vmlinux.

Ugh, a workaround again. As somebody will break that again for sure, I thought
a little bit about it and came up with the appended patch. An (possible?)
explanation is included. I tried it with 0-7 nop's at the old position after
the found_slot label and it always worked. I even did remove the SYNC here and
it still worked. For this final patch I left the SYNC in, cause I don't know
what it is good for. It is against Cort's 990216 vger snapshot, tested on my
7200/75.

Franz.


--- head.S-org	Wed Feb 17 06:59:32 1999
+++ head.S	Sun Feb 21 22:20:49 1999
@@ -1361,13 +1361,6 @@
 found_slot:
 	stw	r6,4(r3)
 	SYNC
-/*
- * These nop's seem to be necessary to avoid getting a machine
- * check on the rfi on 601 processors.
- */
-	nop
-	nop
-
 #else /* __SMP__ */
 /*
  * Between the tlbie above and updating the hash table entry below,
@@ -1441,7 +1434,22 @@
 	lwz	r21,GPR21(r21)
 	SYNC
 	rfi
-	
+
+/* 
+ * These 8 nop's are here to avoid lockup of the 601 on the previous rfi
+ * instruction. They make sure that rfi gets a different cache sector than
+ * the following hash_page_out code and thus the rfi instruction is not 
+ * prefetched by not-taken branch instructions in the hash_page code.
+ */
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+	nop
+
 hash_page_out:
 #ifdef __SMP__
 	lis	r2,hash_table_lock@ha

--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD
Content-Type: text/english;
  name="linux-final.head.S.patch"
Content-Disposition: attachment; filename="linux-final.head.S.patch"
Content-Transfer-Encoding: base64

LS0tIGhlYWQuUy1vcmcJV2VkIEZlYiAxNyAwNjo1OTozMiAxOTk5CisrKyBoZWFkLlMJU3VuIEZl
YiAyMSAyMjoyMDo0OSAxOTk5CkBAIC0xMzYxLDEzICsxMzYxLDYgQEAKIGZvdW5kX3Nsb3Q6CiAJ
c3R3CXI2LDQocjMpCiAJU1lOQwotLyoKLSAqIFRoZXNlIG5vcCdzIHNlZW0gdG8gYmUgbmVjZXNz
YXJ5IHRvIGF2b2lkIGdldHRpbmcgYSBtYWNoaW5lCi0gKiBjaGVjayBvbiB0aGUgcmZpIG9uIDYw
MSBwcm9jZXNzb3JzLgotICovCi0Jbm9wCi0Jbm9wCi0KICNlbHNlIC8qIF9fU01QX18gKi8KIC8q
CiAgKiBCZXR3ZWVuIHRoZSB0bGJpZSBhYm92ZSBhbmQgdXBkYXRpbmcgdGhlIGhhc2ggdGFibGUg
ZW50cnkgYmVsb3csCkBAIC0xNDQxLDcgKzE0MzQsMjIgQEAKIAlsd3oJcjIxLEdQUjIxKHIyMSkK
IAlTWU5DCiAJcmZpCi0JCisKKy8qIAorICogVGhlc2UgOCBub3AncyBhcmUgaGVyZSB0byBhdm9p
ZCBsb2NrdXAgb2YgdGhlIDYwMSBvbiB0aGUgcHJldmlvdXMgcmZpCisgKiBpbnN0cnVjdGlvbi4g
VGhleSBtYWtlIHN1cmUgdGhhdCByZmkgZ2V0cyBhIGRpZmZlcmVudCBjYWNoZSBzZWN0b3IgdGhh
bgorICogdGhlIGZvbGxvd2luZyBoYXNoX3BhZ2Vfb3V0IGNvZGUgYW5kIHRodXMgdGhlIHJmaSBp
bnN0cnVjdGlvbiBpcyBub3QgCisgKiBwcmVmZXRjaGVkIGJ5IG5vdC10YWtlbiBicmFuY2ggaW5z
dHJ1Y3Rpb25zIGluIHRoZSBoYXNoX3BhZ2UgY29kZS4KKyAqLworCW5vcAorCW5vcAorCW5vcAor
CW5vcAorCW5vcAorCW5vcAorCW5vcAorCW5vcAorCiBoYXNoX3BhZ2Vfb3V0OgogI2lmZGVmIF9f
U01QX18KIAlsaXMJcjIsaGFzaF90YWJsZV9sb2NrQGhhCg==

--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD--

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
