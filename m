Return-Path: <diggskevin38@gmail.com>
Received: from mail-iy0-f179.google.com (mail-iy0-f179.google.com
	[209.85.210.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A361C1007D4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 27 Jan 2011 07:08:53 +1100 (EST)
Received: by iye19 with SMTP id 19so806425iye.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Jan 2011 12:08:50 -0800 (PST)
MIME-Version: 1.0
Date: Wed, 26 Jan 2011 14:08:48 -0600
Message-ID: <AANLkTimRdcVtNNt2D=bZJ9n1mY1p2q1R5PN7E1GXhxNx@mail.gmail.com>
Subject: dump_stack doc
From: kevin diggs <diggskevin38@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/mixed; boundary=0022150482b7a7ec1a049ac56661
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0022150482b7a7ec1a049ac56661
Content-Type: text/plain; charset=ISO-8859-1

Hi,

Does this content look ok:

kevdig@SatelliteA75:/usr/src/linux-2.6.36/arch/powerpc/kernel$ diff
-U3 process.c process-new_c
--- process.c	2010-10-23 20:01:13.000000000 -0500
+++ process-new_c	2011-01-26 14:04:17.000000000 -0600
@@ -1107,6 +1107,27 @@

 static int kstack_depth_to_print = CONFIG_PRINT_STACK_DEPTH;

+/**
+ * void show_stack() - dump the contents of the stack in readable format
+ * @struct task_struct *tsk:	pointer to task struct owning stack frame
+ * @unsigned long *stack:	pointer to stack frame	
+ *
+ * Dump the stack in bipedal carbon unit readable form. Format is:
+ * 	Call Trace:
+ * [[	--- Exception: <trap id (%lx)> at <trap handler (%pS)>	]]
+ * [[	    LR = <trapping routine (%pS)>			]]
+ * 	[<stack ("REG")>] [<instruction ("REG")>] <instruction (%pS)> [[
(unreliable)]]
+ *
+ * Information between '[[' & ']]' is optional. Additional information is
+ * printed at the beginning of what are believed to be exception frames.
+ *
+ * The first frame is considered unreliable and will have " (unreliable)"
+ * tacked on the end.
+ *
+ * kstack_depth_to_print determines how many frames to show.
+ *
+ * Value in parenthesis is the format specifier used. See printk().
+ */
 void show_stack(struct task_struct *tsk, unsigned long *stack)
 {
 	unsigned long sp, ip, lr, newsp;
@@ -1177,6 +1198,11 @@
 	} while (count++ < kstack_depth_to_print);
 }

+/**
+ * void dump_stack(void) - dump the contents of the stack in readable form
+ *
+ * See process.c`show_stack() for details
+ */
 void dump_stack(void)
 {
 	show_stack(current, NULL);

kevin

--0022150482b7a7ec1a049ac56661
Content-Type: text/x-diff; charset=US-ASCII; name="process.c.diff"
Content-Disposition: attachment; filename="process.c.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gjeo80fq0

LS0tIHByb2Nlc3MuYwkyMDEwLTEwLTIzIDIwOjAxOjEzLjAwMDAwMDAwMCAtMDUwMAorKysgcHJv
Y2Vzcy1uZXdfYwkyMDExLTAxLTI2IDE0OjA0OjE3LjAwMDAwMDAwMCAtMDYwMApAQCAtMTEwNyw2
ICsxMTA3LDI3IEBACiAKIHN0YXRpYyBpbnQga3N0YWNrX2RlcHRoX3RvX3ByaW50ID0gQ09ORklH
X1BSSU5UX1NUQUNLX0RFUFRIOwogCisvKioKKyAqIHZvaWQgc2hvd19zdGFjaygpIC0gZHVtcCB0
aGUgY29udGVudHMgb2YgdGhlIHN0YWNrIGluIHJlYWRhYmxlIGZvcm1hdAorICogQHN0cnVjdCB0
YXNrX3N0cnVjdCAqdHNrOglwb2ludGVyIHRvIHRhc2sgc3RydWN0IG93bmluZyBzdGFjayBmcmFt
ZQorICogQHVuc2lnbmVkIGxvbmcgKnN0YWNrOglwb2ludGVyIHRvIHN0YWNrIGZyYW1lCQorICoK
KyAqIER1bXAgdGhlIHN0YWNrIGluIGJpcGVkYWwgY2FyYm9uIHVuaXQgcmVhZGFibGUgZm9ybS4g
Rm9ybWF0IGlzOgorICogCUNhbGwgVHJhY2U6CisgKiBbWwktLS0gRXhjZXB0aW9uOiA8dHJhcCBp
ZCAoJWx4KT4gYXQgPHRyYXAgaGFuZGxlciAoJXBTKT4JXV0KKyAqIFtbCSAgICBMUiA9IDx0cmFw
cGluZyByb3V0aW5lICglcFMpPgkJCV1dCisgKiAJWzxzdGFjayAoIlJFRyIpPl0gWzxpbnN0cnVj
dGlvbiAoIlJFRyIpPl0gPGluc3RydWN0aW9uICglcFMpPiBbWyAodW5yZWxpYWJsZSldXQorICoK
KyAqIEluZm9ybWF0aW9uIGJldHdlZW4gJ1tbJyAmICddXScgaXMgb3B0aW9uYWwuIEFkZGl0aW9u
YWwgaW5mb3JtYXRpb24gaXMKKyAqIHByaW50ZWQgYXQgdGhlIGJlZ2lubmluZyBvZiB3aGF0IGFy
ZSBiZWxpZXZlZCB0byBiZSBleGNlcHRpb24gZnJhbWVzLgorICoKKyAqIFRoZSBmaXJzdCBmcmFt
ZSBpcyBjb25zaWRlcmVkIHVucmVsaWFibGUgYW5kIHdpbGwgaGF2ZSAiICh1bnJlbGlhYmxlKSIK
KyAqIHRhY2tlZCBvbiB0aGUgZW5kLgorICoKKyAqIGtzdGFja19kZXB0aF90b19wcmludCBkZXRl
cm1pbmVzIGhvdyBtYW55IGZyYW1lcyB0byBzaG93LgorICoKKyAqIFZhbHVlIGluIHBhcmVudGhl
c2lzIGlzIHRoZSBmb3JtYXQgc3BlY2lmaWVyIHVzZWQuIFNlZSBwcmludGsoKS4KKyAqLwogdm9p
ZCBzaG93X3N0YWNrKHN0cnVjdCB0YXNrX3N0cnVjdCAqdHNrLCB1bnNpZ25lZCBsb25nICpzdGFj
aykKIHsKIAl1bnNpZ25lZCBsb25nIHNwLCBpcCwgbHIsIG5ld3NwOwpAQCAtMTE3Nyw2ICsxMTk4
LDExIEBACiAJfSB3aGlsZSAoY291bnQrKyA8IGtzdGFja19kZXB0aF90b19wcmludCk7CiB9CiAK
Ky8qKgorICogdm9pZCBkdW1wX3N0YWNrKHZvaWQpIC0gZHVtcCB0aGUgY29udGVudHMgb2YgdGhl
IHN0YWNrIGluIHJlYWRhYmxlIGZvcm0KKyAqCisgKiBTZWUgcHJvY2Vzcy5jYHNob3dfc3RhY2so
KSBmb3IgZGV0YWlscworICovCiB2b2lkIGR1bXBfc3RhY2sodm9pZCkKIHsKIAlzaG93X3N0YWNr
KGN1cnJlbnQsIE5VTEwpOwo=
--0022150482b7a7ec1a049ac56661--
