Return-Path: <devhexorg@gmail.com>
Received: from mail-qc0-x244.google.com (mail-qc0-x244.google.com
 [IPv6:2607:f8b0:400d:c01::244])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 783A92C012D
 for <linuxppc-dev@ozlabs.org>; Sat, 23 Nov 2013 08:09:33 +1100 (EST)
Received: by mail-qc0-f196.google.com with SMTP id r5so202463qcx.3
 for <linuxppc-dev@ozlabs.org>; Fri, 22 Nov 2013 13:09:30 -0800 (PST)
MIME-Version: 1.0
Date: Fri, 22 Nov 2013 15:09:29 -0600
Message-ID: <CA+2fWjZRw7zdCACXXSTPN4QVeuXN5CLOZSOJJiGuP4UBcS2aMA@mail.gmail.com>
Subject: Windfarm's max6690 sensor driver was not included in makefile
From: Stanislav Ponomarev <devhexorg@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/mixed; boundary=047d7b6dcd0416c89904ebca6eb6
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--047d7b6dcd0416c89904ebca6eb6
Content-Type: multipart/alternative; boundary=047d7b6dcd0416c89004ebca6eb4

--047d7b6dcd0416c89004ebca6eb4
Content-Type: text/plain; charset=ISO-8859-1

Hello, I had problems with fan speed in my XServe G5. It turned out
drivers/macintosh/Makefile has a max6690 module missing from compilation
list. I was advised to mail the patch to you guys.

I'm not sure what's the proper format of the patch to be submitten (this is
my first time). So I'm including it into the message body, and as an
attached file.

diff --git a/drivers/macintosh/Makefile b/drivers/macintosh/Makefile
index 6753b65..d2f0120 100644
--- a/drivers/macintosh/Makefile
+++ b/drivers/macintosh/Makefile
@@ -40,6 +40,7 @@ obj-$(CONFIG_WINDFARM_RM31)     +=
windfarm_fcu_controls.o \
                                   windfarm_ad7417_sensor.o \
                                   windfarm_lm75_sensor.o \
                                   windfarm_lm87_sensor.o \
+                                  windfarm_max6690_sensor.o \
                                   windfarm_pid.o \
                                   windfarm_cpufreq_clamp.o \
                                   windfarm_rm31.o


Thank you.
Stanislav Ponomarev.

--047d7b6dcd0416c89004ebca6eb4
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: base64

PGRpdiBkaXI9Imx0ciI+PGRpdj5IZWxsbywgSSBoYWQgcHJvYmxlbXMgd2l0aCBmYW4gc3BlZWQg
aW4gbXkgWFNlcnZlIEc1LiBJdCB0dXJuZWQgb3V0IGRyaXZlcnMvbWFjaW50b3NoL01ha2VmaWxl
IGhhcyBhIG1heDY2OTAgbW9kdWxlIG1pc3NpbmcgZnJvbSBjb21waWxhdGlvbiBsaXN0LiBJIHdh
cyBhZHZpc2VkIHRvIG1haWwgdGhlIHBhdGNoIHRvIHlvdSBndXlzLjxicj48YnI+PC9kaXY+DQpJ
JiMzOTttIG5vdCBzdXJlIHdoYXQmIzM5O3MgdGhlIHByb3BlciBmb3JtYXQgb2YgdGhlIHBhdGNo
IHRvIGJlIHN1Ym1pdHRlbiAodGhpcyBpcyBteSBmaXJzdCB0aW1lKS4gU28gSSYjMzk7bSBpbmNs
dWRpbmcgaXQgaW50byB0aGUgbWVzc2FnZSBib2R5LCBhbmQgYXMgYW4gYXR0YWNoZWQgZmlsZS48
YnI+PGRpdj48YnI+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbWFjaW50b3NoL01ha2VmaWxlIGIvZHJp
dmVycy9tYWNpbnRvc2gvTWFrZWZpbGU8YnI+DQppbmRleCA2NzUzYjY1Li5kMmYwMTIwIDEwMDY0
NDxicj4tLS0gYS9kcml2ZXJzL21hY2ludG9zaC9NYWtlZmlsZTxicj4rKysgYi9kcml2ZXJzL21h
Y2ludG9zaC9NYWtlZmlsZTxicj5AQCAtNDAsNiArNDAsNyBAQCBvYmotJChDT05GSUdfV0lOREZB
Uk1fUk0zMSmgoKCgICs9IHdpbmRmYXJtX2ZjdV9jb250cm9scy5vIFw8YnI+oKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoCB3aW5kZmFybV9hZDc0MTdfc2Vuc29yLm8gXDxicj4NCqCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgd2luZGZhcm1fbG03NV9zZW5zb3IubyBc
PGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgd2luZGZhcm1fbG04N19zZW5z
b3IubyBcPGJyPiugoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgd2luZGZhcm1fbWF4
NjY5MF9zZW5zb3IubyBcPGJyPqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgd2lu
ZGZhcm1fcGlkLm8gXDxicj4NCqCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKAgd2lu
ZGZhcm1fY3B1ZnJlcV9jbGFtcC5vIFw8YnI+oKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oKCgoCB3aW5kZmFybV9ybTMxLm88YnI+PGJyPjxicj48L2Rpdj48ZGl2PlRoYW5rIHlvdS48YnI+
PC9kaXY+PGRpdj5TdGFuaXNsYXYgUG9ub21hcmV2Ljxicj48L2Rpdj48L2Rpdj4NCg==
--047d7b6dcd0416c89004ebca6eb4--

--047d7b6dcd0416c89904ebca6eb6
Content-Type: text/x-patch; charset=US-ASCII; name="Makefile.patch"
Content-Disposition: attachment; filename="Makefile.patch"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_hobx996u0

aW5kZXggNjc1M2I2NS4uZDJmMDEyMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9tYWNpbnRvc2gvTWFr
ZWZpbGUKKysrIGIvZHJpdmVycy9tYWNpbnRvc2gvTWFrZWZpbGUKQEAgLTQwLDYgKzQwLDcgQEAg
b2JqLSQoQ09ORklHX1dJTkRGQVJNX1JNMzEpICAgICArPSB3aW5kZmFybV9mY3VfY29udHJvbHMu
byBcCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgd2luZGZhcm1fYWQ3NDE3X3Nl
bnNvci5vIFwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB3aW5kZmFybV9sbTc1
X3NlbnNvci5vIFwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB3aW5kZmFybV9s
bTg3X3NlbnNvci5vIFwKKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB3aW5kZmFy
bV9tYXg2NjkwX3NlbnNvci5vIFwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB3
aW5kZmFybV9waWQubyBcCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgd2luZGZh
cm1fY3B1ZnJlcV9jbGFtcC5vIFwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB3
aW5kZmFybV9ybTMxLm8K
--047d7b6dcd0416c89904ebca6eb6--
