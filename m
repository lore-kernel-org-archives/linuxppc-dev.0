Return-Path: <m.louvel@gmail.com>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.234])
	by ozlabs.org (Postfix) with ESMTP id 818F9DDE17
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Feb 2008 23:37:12 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so2701775wxd.15
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Feb 2008 04:37:11 -0800 (PST)
Message-ID: <dda529d0802270437o3ea1c9beld7d65f5af2011a6f@mail.gmail.com>
Date: Wed, 27 Feb 2008 12:37:11 +0000
From: "maxime louvel" <m.louvel@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: 2.6.25-rc3 on mpc8548amc doesn't boot
MIME-Version: 1.0
Content-Type: multipart/mixed;
	boundary="----=_Part_5855_8040191.1204115831213"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_5855_8040191.1204115831213
Content-Type: multipart/alternative;
	boundary="----=_Part_5856_16318217.1204115831214"

------=_Part_5856_16318217.1204115831214
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,

I am still trying to make a 2.6.25-rc3 vanilla kernel boot (an work fine in
a second time) on a mpc8548amc board.
I have add the platform specific stuff from the sources of the current
kernel running on the cards.
What I have basically add is:
- arch/powerpc/platforms/85xx/mpc85xx_amc.c
- arch/powerpc/boot/dts/mpc8548amc.dts
I have also changed the Kconfig and Makefile in the
arch/powerpc/platforms/85xx to make the kernel try to support my board

I have encountered some problem when compiling a uImage that I have
basically solve like this (in arch/powerpc/boot/Makefile)
#$(obj)/4xx.o: BOOTCFLAGS += -mcpu=405
#$(obj)/ebony.o: BOOTCFLAGS += -mcpu=405
#$(obj)/cuboot-taishan.o: BOOTCFLAGS += -mcpu=405
#$(obj)/cuboot-katmai.o: BOOTCFLAGS += -mcpu=405
#$(obj)/treeboot-walnut.o: BOOTCFLAGS += -mcpu=405

I have a gcc-3.4.3 embedded compiler with some stuff specific to the
platform.

After the previous hack, I have been able to compile a uImage.

I have tried to boot it and this is what I got:
AMC=> bootm 0x1000000
## Booting image at 01000000 ...
  Image Name:   Linux-2.6.24
  Image Type:   PowerPC Linux Kernel Image (gzip compressed)
  Data Size:    1802038 Bytes =  1.7 MB
  Load Address: 00000000
  Entry Point:  00000000
  Verifying Checksum ... OK
  Uncompressing Kernel Image ... OK

No further messages...

I have recently updated the uboot of the cards (to support the new image
version) and I am capable of booting a 2.6.23.6 image.
This last image has been compiled from a vanilla kernel where I have add the
platform specific stuff (cf beginning of this mail).

Since my 2.6.23.6 image works fine, I have tried to adapt the file I have
added to the 2.6.25-rc3 kernel.

I have made some changes in the arch/powerpc/platforms/85xx/mpc85xx_amc.c
file and in the mpc8548amc.dts file.
I have attached the changes I have done on both files.

Do you have an idea ?

cheers,
Maxime

-- 
Maxime Louvel
0044 7964 5555 80
43 Allen road
Whitemore reans
WV60AW Wolverhampton
United Kingdom

------=_Part_5856_16318217.1204115831214
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi,<br><br>I am still trying to make a 2.6.25-rc3 vanilla kernel boot (an work fine in a second time) on a mpc8548amc board.<br>I
have add the platform
specific stuff from the sources of the current kernel running on the
cards.<br>



What I have basically add is:<br>- arch/powerpc/platforms/85xx/mpc85xx_amc.c<br>- arch/powerpc/boot/dts/mpc8548amc.dts<br>I have also changed the Kconfig and Makefile in the arch/powerpc/platforms/85xx to make the kernel try to support my board<br>
<br>I have encountered some problem when compiling a uImage that I have basically solve like this (in arch/powerpc/boot/Makefile)<br>#$(obj)/4xx.o: BOOTCFLAGS += -mcpu=405<br>#$(obj)/ebony.o: BOOTCFLAGS += -mcpu=405<br>#$(obj)/cuboot-taishan.o: BOOTCFLAGS += -mcpu=405<br>
#$(obj)/cuboot-katmai.o: BOOTCFLAGS += -mcpu=405<br>#$(obj)/treeboot-walnut.o: BOOTCFLAGS += -mcpu=405<br><br>I have a gcc-3.4.3 embedded compiler with some stuff specific to the platform.<br><br>After the previous hack, I have been able to compile a uImage.<br>
<br>I have tried to boot it and this is what I got:<br>AMC=&gt; bootm 0x1000000<br>## Booting image at 01000000 ...<br> &nbsp; Image Name: &nbsp; Linux-2.6.24<br> &nbsp; Image Type: &nbsp; PowerPC Linux Kernel Image (gzip compressed)<br>





 &nbsp; Data Size: &nbsp; &nbsp;1802038 Bytes = &nbsp;1.7 MB<br> &nbsp; Load Address: 00000000<br> &nbsp; Entry Point: &nbsp;00000000<br> &nbsp; Verifying Checksum ... OK<br> &nbsp; Uncompressing Kernel Image ... OK<br><br>No further messages...<br><br>I have recently updated the uboot of the cards (to support the new image version) and I am capable of booting a <a href="http://2.6.23.6">2.6.23.6</a> image.<br>
This last image has been compiled from a vanilla kernel where I have add the platform specific stuff (cf beginning of this mail).<br><br>Since my <a href="http://2.6.23.6">2.6.23.6</a> image works fine, I have tried to adapt the file I have added to the 2.6.25-rc3 kernel.<br>
<br>I have made some changes in the arch/powerpc/platforms/85xx/mpc85xx_amc.c file and in the mpc8548amc.dts file.<br>I have attached the changes I have done on both files.<br><br>Do you have an idea ?<br><br>cheers,<br>Maxime<br clear="all">
<br>-- <br>Maxime Louvel<br>0044 7964 5555 80<br>43 Allen road<br>Whitemore reans<br>WV60AW Wolverhampton<br>United Kingdom

------=_Part_5856_16318217.1204115831214--

------=_Part_5855_8040191.1204115831213
Content-Type: application/octet-stream;
 name=2.6.23.6.mpc8548_amc_2.6.25-rc3.mpc85xx_amc
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fd5vekap0
Content-Disposition: attachment;
 filename=2.6.23.6.mpc8548_amc_2.6.25-rc3.mpc85xx_amc

LS0tIC4uLy4uL3NyY0NoYW5nZXMvMi42LjIzLjYvbXBjODU0OF9hbWMuYwkyMDA4LTAyLTI3IDEy
OjI3OjMzLjAwMDAwMDAwMCArMDAwMAorKysgbGludXgtMi42LjI1LXJjM19jaGFuZ2VkL2FyY2gv
cG93ZXJwYy9wbGF0Zm9ybXMvODV4eC9tcGM4NXh4X2FtYy5jCTIwMDgtMDItMjcgMTA6Mjk6MTMu
MDAwMDAwMDAwICswMDAwCkBAIC0xLDUgKzEsNSBAQAogLyoKLSAqIE1QQzg1NDggQU1DIGJvYXJk
IHNwZWNpZmljIHJvdXRpbmVzCisgKiBNUEM4NXh4IEFNQyBib2FyZCBzcGVjaWZpYyByb3V0aW5l
cwogICoKICAqIENvcHlyaWdodCAyMDA2IEZyZWVzY2FsZSBTZW1pY29uZHVjdG9yIEluYy4KICAq
CkBAIC0yMywxNCArMjMsMjAgQEAKICNpbmNsdWRlIDxhc20vcHJvbS5oPgogI2luY2x1ZGUgPG1t
L21tdV9kZWNsLmg+CiAjaW5jbHVkZSA8YXNtL3VkYmcuaD4KLSNpbmNsdWRlIDxhc20vb2ZfZGV2
aWNlLmg+Ci0jaW5jbHVkZSA8YXNtL29mX3BsYXRmb3JtLmg+CisvKiAjaW5jbHVkZSA8YXNtL29m
X2RldmljZS5oPiAqLworLyogI2luY2x1ZGUgPGFzbS9vZl9wbGF0Zm9ybS5oPiAqLworLyogY29t
bWl0OgorICogW1BPV0VSUENdIDh4eHg6IENvbnZlcnQgI2luY2x1ZGUgb2YgYXNtL29mX3twbGF0
Zm9ybSwgZGV2aWNlfS5oCisgICAgICAgICAgICAgICAgICAgaW50byBsaW51eC9vZl97cGxhdGZv
cm0sIGRldmljZX0uaC4KKyAqLworI2luY2x1ZGUgPGxpbnV4L29mX2RldmljZS5oPiAgCisjaW5j
bHVkZSA8bGludXgvb2ZfcGxhdGZvcm0uaD4KIAogI2luY2x1ZGUgPGFzbS9tcGljLmg+CiAKICNp
bmNsdWRlIDxzeXNkZXYvZnNsX3NvYy5oPgotLyojaW5jbHVkZSA8c3lzZGV2L2ZzbF9yaW8uaD4q
LwotI2luY2x1ZGUgIm1wYzg1eHguaCIKKyNpbmNsdWRlIDxzeXNkZXYvZnNsX3Jpby5oPgorLyog
I2luY2x1ZGUgIm1wYzg1eHguaCIgKi8KIAogI2lmbmRlZiBDT05GSUdfUENJCiB1bnNpZ25lZCBs
b25nIGlzYV9pb19iYXNlID0gMDsKQEAgLTE0MSw3ICsxNDcsNyBAQAogCS5pbml0X0lSUQkJPSBt
cGM4NXh4X2FtY19waWNfaW5pdCwKIAkuc2hvd19jcHVpbmZvCQk9IG1wYzg1eHhfYW1jX3Nob3df
Y3B1aW5mbywKIAkuZ2V0X2lycQkJPSBtcGljX2dldF9pcnEsCi0JLnJlc3RhcnQJCT0gbXBjODV4
eF9yZXN0YXJ0LAorCS5yZXN0YXJ0CQk9IGZzbF9yc3Rjcl9yZXN0YXJ0LAogCS5jYWxpYnJhdGVf
ZGVjcgkJPSBnZW5lcmljX2NhbGlicmF0ZV9kZWNyLAogCS5wcm9ncmVzcwkJPSB1ZGJnX3Byb2dy
ZXNzLAogfTsK
------=_Part_5855_8040191.1204115831213
Content-Type: application/octet-stream;
 name=2.6.23.6.mpc8548dts_2.6.25-rc3.mpc8548dts
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fd5veq5t1
Content-Disposition: attachment;
 filename=2.6.23.6.mpc8548dts_2.6.25-rc3.mpc8548dts

LS0tIC4uLy4uL3NyY0NoYW5nZXMvMi42LjIzLjYvbXBjODU0OGFtYy5kdHMJMjAwOC0wMi0yNyAx
MjoyNzo0Ni4wMDAwMDAwMDAgKzAwMDAKKysrIGxpbnV4LTIuNi4yNS1yYzNfY2hhbmdlZC9hcmNo
L3Bvd2VycGMvYm9vdC9kdHMvbXBjODU0OGFtYy5kdHMJMjAwOC0wMi0yNyAxMDoyMjoxMy4wMDAw
MDAwMDAgKzAwMDAKQEAgLTE1LDYgKzE1LDEyIEBACiAJY29tcGF0aWJsZSA9ICJNUEM4NTQ4QU1D
IjsKIAkjYWRkcmVzcy1jZWxscyA9IDwxPjsKIAkjc2l6ZS1jZWxscyA9IDwxPjsKKwlhbGlhc2Vz
IHsKKwkgICAgICAgIGV0aGVybmV0MCA9ICZlbmV0MDsKKwkJZXRoZXJuZXQxID0gJmVuZXQxOwor
CQlldGhlcm5ldDIgPSAmZW5ldDI7CisJCWV0aGVybmV0MyA9ICZlbmV0MzsKKyAgICAgICAgfTsK
IAogCWNwdXMgewogCQkjY3B1cyA9IDwxPjsKQEAgLTMxLDcgKzM3LDYgQEAKIAkJCXRpbWViYXNl
LWZyZXF1ZW5jeSA9IDwwPjsJLy8gMzMgTUh6LCBmcm9tIHVib290CiAJCQlidXMtZnJlcXVlbmN5
ID0gPDA+OwkJLy8gRnJvbSB1Ym9vdAogCQkJY2xvY2stZnJlcXVlbmN5ID0gPDA+OwkJLy8gRnJv
bSB1Ym9vdAotCQkJMzItYml0OwogCQl9OwogCX07CiAKQEAgLTQzLDE0ICs0OCwxNSBAQAogCXNv
Yzg1NDhAZTAwMDAwMDAgewogCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKIAkJI3NpemUtY2VsbHMg
PSA8MT47Ci0JCSNpbnRlcnJ1cHQtY2VsbHMgPSA8Mj47CiAJCWRldmljZV90eXBlID0gInNvYyI7
CiAJCXJhbmdlcyA9IDwwIGUwMDAwMDAwIDAwMTAwMDAwPjsKIAkJcmVnID0gPGUwMDAwMDAwIDAw
MTAwMDAwPjsJLy8gQ0NTUkJBUiAxTQogCQlidXMtZnJlcXVlbmN5ID0gPDA+OwotCisJCiAJCWky
Y0AzMDAwIHsKLQkJCWRldmljZV90eXBlID0gImkyYyI7CisJCQkjYWRkcmVzcy1jZWxscyA9IDwx
PjsKKwkJCSNzaXplLWNlbGxzID0gPDA+OworCQkJY2VsbC1pbmRleCA9IDwwPgogCQkJY29tcGF0
aWJsZSA9ICJmc2wtaTJjIjsKIAkJCXJlZyA9IDwzMDAwIDEwMD47CiAJCQlpbnRlcnJ1cHRzID0g
PDFiIDI+OwpAQCAtNTgsMTMgKzY0LDI0IEBACiAJCQlkZnNycjsKIAkJfTsKIAorCQlpMmNAMzEw
MCB7CisJCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKKwkJCSNzaXplLWNlbGxzID0gPDA+OworCQkJ
Y2VsbC1pbmRleCA9IDwxPjsKKwkJCWNvbXBhdGlibGUgPSAiZnNsLWkyYyI7CisJCQlyZWcgPSA8
MzEwMCAxMDA+OworCQkJaW50ZXJydXB0cyA9IDwxYiAyPjsKKwkJCWludGVycnVwdC1wYXJlbnQg
PSA8Jm1waWM+OworCQkJZGZzcnI7CisJCX07CisKIAkJbWRpb0AyNDUyMCB7CiAJCQkjYWRkcmVz
cy1jZWxscyA9IDwxPjsKIAkJCSNzaXplLWNlbGxzID0gPDA+OwotCQkJZGV2aWNlX3R5cGUgPSAi
bWRpbyI7Ci0JCQljb21wYXRpYmxlID0gImdpYW5mYXIiOworCQkJY29tcGF0aWJsZSA9ICJmc2ws
Z2lhbmZhci1tZGlvIjsKIAkJCXJlZyA9IDwyNDUyMCAyMD47CiAJCQlsaW51eCxwaGFuZGxlID0g
PDI0NTIwPjsKKwkJCQogCQkJcGh5MDogZXRoZXJuZXQtcGh5QDEwIHsKIAkJCQlpbnRlcnJ1cHQt
cGFyZW50ID0gPCZtcGljPjsKIAkJCQlpbnRlcnJ1cHRzID0gPDM0IDE+OwpAQCAtOTEsOSArMTA4
LDggQEAKIAkJCX07CiAJCX07CiAKLQkJZXRoZXJuZXRAMjQwMDAgewotCQkJI2FkZHJlc3MtY2Vs
bHMgPSA8MT47Ci0JCQkjc2l6ZS1jZWxscyA9IDwwPjsKKwkJZW5ldDA6IGV0aGVybmV0QDI0MDAw
IHsKKwkJICAgICAgICBjZWxsLWluZGV4ID0gPDA+OwogCQkJZGV2aWNlX3R5cGUgPSAibmV0d29y
ayI7CiAJCQltb2RlbCA9ICJlVFNFQyI7CiAJCQljb21wYXRpYmxlID0gImdpYW5mYXIiOwpAQCAt
MTA0LDkgKzEyMCw4IEBACiAJCQlwaHktaGFuZGxlID0gPCZwaHkwPjsKIAkJfTsKIAotCQlldGhl
cm5ldEAyNTAwMCB7Ci0JCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKLQkJCSNzaXplLWNlbGxzID0g
PDA+OworCQllbmV0MTogZXRoZXJuZXRAMjUwMDAgeworCQkgICAgICAgIGNlbGwtaW5kZXggPSA8
MT47CiAJCQlkZXZpY2VfdHlwZSA9ICJuZXR3b3JrIjsKIAkJCW1vZGVsID0gImVUU0VDIjsKIAkJ
CWNvbXBhdGlibGUgPSAiZ2lhbmZhciI7CkBAIC0xMTcsOSArMTMyLDggQEAKIAkJCXBoeS1oYW5k
bGUgPSA8JnBoeTE+OwogCQl9OwogCQkKLQkJZXRoZXJuZXRAMjYwMDAgewotCQkJI2FkZHJlc3Mt
Y2VsbHMgPSA8MT47Ci0JCQkjc2l6ZS1jZWxscyA9IDwwPjsKKwkJZW5ldDM6IGV0aGVybmV0QDI2
MDAwIHsKKwkJICAgICAgICBjZWxsLWluZGV4ID0gPDI+OwogCQkJZGV2aWNlX3R5cGUgPSAibmV0
d29yayI7CiAJCQltb2RlbCA9ICJlVFNFQyI7CiAJCQljb21wYXRpYmxlID0gImdpYW5mYXIiOwpA
QCAtMTMwLDkgKzE0NCw4IEBACiAJCQlwaHktaGFuZGxlID0gPCZwaHkyPjsKIAkJfTsKIAotCQll
dGhlcm5ldEAyNzAwMCB7Ci0JCQkjYWRkcmVzcy1jZWxscyA9IDwxPjsKLQkJCSNzaXplLWNlbGxz
ID0gPDA+OworCQllbmV0NDogZXRoZXJuZXRAMjcwMDAgeworCQkgICAgICAgIGNlbGwtaW5kZXgg
PSA8Mz47CiAJCQlkZXZpY2VfdHlwZSA9ICJuZXR3b3JrIjsKIAkJCW1vZGVsID0gImVUU0VDIjsK
IAkJCWNvbXBhdGlibGUgPSAiZ2lhbmZhciI7Cg==
------=_Part_5855_8040191.1204115831213--
