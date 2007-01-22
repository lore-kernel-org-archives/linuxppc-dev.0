Return-Path: <benjamin.zores@alcatel-lucent.fr>
Received: from smail2.alcatel.fr (smail2.alcatel.fr [62.23.212.57])
	by ozlabs.org (Postfix) with ESMTP id 65F0FDDF1C
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 23 Jan 2007 08:44:02 +1100 (EST)
Received: from bsf.alcatel.fr (mail205.sxb.bsf.alcatel.fr [155.132.205.115])
	by smail2.alcatel.fr (ALCANET/NETFR) with ESMTP id l0MHh1QH001360
	for <linuxppc-embedded@ozlabs.org>; Mon, 22 Jan 2007 18:46:44 +0100
Received: from mail (mail-bsf-alcatel-fr.sxb.bsf.alcatel.fr [155.132.205.91])
	by bsf.alcatel.fr (8.8.8p2+Sun/8.9.3) with ESMTP id SAA05652
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 Jan 2007 18:14:37 +0100 (MET)
Received: from frilld0063506 (frilld0063506 [172.25.48.83])
	by mail (8.8.8p2+Sun/) with SMTP id SAA05648
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 Jan 2007 18:14:37 +0100 (MET)
Date: Mon, 22 Jan 2007 18:10:27 +0100
From: Benjamin Zores <benjamin.zores@alcatel-lucent.fr>
To: linuxppc-embedded@ozlabs.org
Subject: [MPC8349ITX] USB Init with PPC arch
Message-Id: <20070122181027.89187533.benjamin.zores@alcatel-lucent.fr>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart=_Mon__22_Jan_2007_18_10_27_+0100_VPLYgvx7vPSr7kQI"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

--Multipart=_Mon__22_Jan_2007_18_10_27_+0100_VPLYgvx7vPSr7kQI
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi,

This question is mainly intended to Freescale's MPC8349ITX board maintainer
but the issue/resolution is probably the same for other boards.

I'm trying to boot the MPC8349ITX card with Linux 2.6.19 using old PPC
architecture (and not the new PowerPC one).
I've ported patches from Freescale's BSP from 2.6.13 to 2.6.19 and
it works pretty well but USB doesn't init properly.

Switching to PowerPC arch of course works fine and USB is well inited
but due to other feature i use that only exist on PPC right now, I can't
make use of it.

So I've added the attached patched to my PPC kernel in order to initialize
the USB controller the same way it is done in DTS file for PowerPC arch.
The goal is of course to use the regular EHCI-FSL driver.

I've noticed that PowerPC arch starts by initing the DR controller than MPH one.
On PPC it's the opposite way. Although I have to not initialize the DR one, which
seems to completely hang the card at USB controller probe.

Initializing the MPH controller seems to work fine but then
USB stack has a lot of errors which seem to come from bad EHCI-FSL init.
(see below)

fsl-ehci fsl-ehci.1: No platform data for fsl-ehci.1.               
fsl-ehci fsl-ehci.2: Freescale On-Chip EHCI Host Controller               
fsl-ehci fsl-ehci.2: new USB bus registered, assigned bus number 1      
fsl-ehci fsl-ehci.2: irq 39, io base 0xe0022000                                
fsl-ehci fsl-ehci.2: USB 2.0 started, EHCI 1.00, driver 10 Dec 2004     
usb usb1: Product: Freescale On-Chip EHCI Host Controller                
usb usb1: Manufacturer: Linux 2.6.19.2-fsl ehci_hcd                            
usb usb1: SerialNumber: fsl-ehci.2                                  
usb usb1: configuration #1 chosen from 1 choice                        
hub 1-0:1.0: USB hub found                                     
hub 1-0:1.0: 2 ports detected                                           
USB Universal Host Controller Interface driver v3.0           
Initializing USB Mass Storage driver...                                  
usb 1-1: new high speed USB device using fsl-ehci and address 2  
usb 1-1: device descriptor read/64, error -32                     
usb 1-1: device descriptor read/64, error -32            
usb 1-1: new high speed USB device using fsl-ehci and address 3  
usb 1-1: device descriptor read/64, error -32                 
usb 1-1: device descriptor read/64, error -32                  
usb 1-1: new high speed USB device using fsl-ehci and address 4     
usb 1-1: device not accepting address 4, error -32              
usb 1-1: new high speed USB device using fsl-ehci and address 5
usb 1-1: device not accepting address 5, error -32                   
usbcore: registered new interface driver usb-storage   
USB Mass Storage support registered.

Of course, the USB controller isn't working afterwards
and no USB device can be used.

Does anyone has an idea where the problem might come from and how to solve it
(once again, switching to PowerPC arch is ok but i don't want to).

Thx in advance,

Regards,

Ben


--Multipart=_Mon__22_Jan_2007_18_10_27_+0100_VPLYgvx7vPSr7kQI
Content-Type: application/octet-stream;
 name="usb.patch"
Content-Disposition: attachment;
 filename="usb.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtTkV3YWJ1ciAteCAnKn4nIC14IGxpbnV4Lm9yaWcgLXggJyoucmVqJyBsaW51eC5vcmln
L2FyY2gvcHBjL3BsYXRmb3Jtcy84M3h4L21wYzgzNHhfaXR4LmMgbGludXguZWRpdC9hcmNoL3Bw
Yy9wbGF0Zm9ybXMvODN4eC9tcGM4MzR4X2l0eC5jCi0tLSBsaW51eC5vcmlnL2FyY2gvcHBjL3Bs
YXRmb3Jtcy84M3h4L21wYzgzNHhfaXR4LmMJMjAwNy0wMS0yMiAxOTowMDowOS4wMDAwMDAwMDAg
KzAxMDAKKysrIGxpbnV4LmVkaXQvYXJjaC9wcGMvcGxhdGZvcm1zLzgzeHgvbXBjODM0eF9pdHgu
YwkyMDA3LTAxLTIyIDE4OjQwOjQyLjAwMDAwMDAwMCArMDEwMApAQCAtMjEwLDYgKzIxMCw3IEBA
CiAgIHVuc2lnbmVkIGludCBmcmVxOwogICBzdHJ1Y3QgZ2lhbmZhcl9wbGF0Zm9ybV9kYXRhICpw
ZGF0YTsKICAgc3RydWN0IGdpYW5mYXJfbWRpb19kYXRhICptZGF0YTsKKyAgc3RydWN0IGZzbF91
c2IyX3BsYXRmb3JtX2RhdGEgKnVkYXRhOwogCiAgIC8qIGdldCB0aGUgY29yZSBmcmVxdWVuY3kg
Ki8KICAgZnJlcSA9IGJpbmZvLT5iaV9pbnRmcmVxOwpAQCAtMjQ3LDYgKzI0OCwxNyBAQAogICAg
IG1lbWNweSAocGRhdGEtPm1hY19hZGRyLCBiaW5mby0+YmlfZW5ldDFhZGRyLCA2KTsKICAgfQog
ICAKKyAgLyogc2V0dXAgdGhlIGJvYXJkIHJlbGF0ZWQgaW5mb3JtYXRpb24gZm9yIHRoZSBVU0Ig
Y29udHJvbGxlcnMgKi8KKyAgdWRhdGE9KHN0cnVjdCBmc2xfdXNiMl9wbGF0Zm9ybV9kYXRhICop
cHBjX3N5c19nZXRfcGRhdGEoTVBDODN4eF9VU0IyX01QSCk7CisgIGlmICh1ZGF0YSkgeworICAg
IHVkYXRhLT5vcGVyYXRpbmdfbW9kZSA9IEZTTF9VU0IyX01QSF9IT1NUOworICAgIHVkYXRhLT5w
b3J0X2VuYWJsZXMgfD0gRlNMX1VTQjJfUE9SVDFfRU5BQkxFRDsKKyAgfQorCisgIHVkYXRhPShz
dHJ1Y3QgZnNsX3VzYjJfcGxhdGZvcm1fZGF0YSAqKXBwY19zeXNfZ2V0X3BkYXRhKE1QQzgzeHhf
VVNCMl9EUik7CisgIGlmICh1ZGF0YSkKKyAgICB1ZGF0YS0+b3BlcmF0aW5nX21vZGUgPSBGU0xf
VVNCMl9EUl9IT1NUOworICAKICNpZmRlZiBDT05GSUdfQkxLX0RFVl9JTklUUkQKICAgaWYgKGlu
aXRyZF9zdGFydCkKICAgICBST09UX0RFViA9IFJvb3RfUkFNMDsKZGlmZiAtTkV3YWJ1ciAteCAn
Kn4nIC14IGxpbnV4Lm9yaWcgLXggJyoucmVqJyBsaW51eC5vcmlnL2FyY2gvcHBjL3N5c2xpYi9t
cGM4M3h4X2RldmljZXMuYyBsaW51eC5lZGl0L2FyY2gvcHBjL3N5c2xpYi9tcGM4M3h4X2Rldmlj
ZXMuYwotLS0gbGludXgub3JpZy9hcmNoL3BwYy9zeXNsaWIvbXBjODN4eF9kZXZpY2VzLmMJMjAw
Ny0wMS0xMCAyMDoxMDozNy4wMDAwMDAwMDAgKzAxMDAKKysrIGxpbnV4LmVkaXQvYXJjaC9wcGMv
c3lzbGliL21wYzgzeHhfZGV2aWNlcy5jCTIwMDctMDEtMjIgMTg6NDU6MjUuMDAwMDAwMDAwICsw
MTAwCkBAIC00OCw2ICs0OCwxNiBAQAogCS5kZXZpY2VfZmxhZ3MgPSBGU0xfSTJDX0RFVl9TRVBB
UkFURV9ERlNSUiwKIH07CiAKK3N0YXRpYyBzdHJ1Y3QgZnNsX3VzYjJfcGxhdGZvcm1fZGF0YSBt
cGM4M3h4X3VzYjJfZHJfcGRhdGEgPSB7CisgICAgICAgIC5waHlfbW9kZSA9IEZTTF9VU0IyX1BI
WV9VTFBJLAorICAgICAgICAucG9ydF9lbmFibGVzID0gMCwKK307CisKK3N0YXRpYyBzdHJ1Y3Qg
ZnNsX3VzYjJfcGxhdGZvcm1fZGF0YSBtcGM4M3h4X3VzYjJfbXBoX3BkYXRhID0geworICAgICAg
ICAucGh5X21vZGUgPSBGU0xfVVNCMl9QSFlfVUxQSSwKKyAgICAgICAgLnBvcnRfZW5hYmxlcyA9
IDAsCit9OworCiBzdGF0aWMgc3RydWN0IHBsYXRfc2VyaWFsODI1MF9wb3J0IHNlcmlhbF9wbGF0
Zm9ybV9kYXRhW10gPSB7CiAJWzBdID0gewogCQkubWFwYmFzZQk9IDB4NDUwMCwKQEAgLTE4OSw2
ICsxOTksNyBAQAogCQkubmFtZSA9ICJmc2wtZWhjaSIsCiAJCS5pZAk9IDEsCiAJCS5udW1fcmVz
b3VyY2VzCSA9IDIsCisgICAgICAgICAgICAgICAgLy8uZGV2LnBsYXRmb3JtX2RhdGEgPSAmbXBj
ODN4eF91c2IyX2RyX3BkYXRhLAogCQkucmVzb3VyY2UgPSAoc3RydWN0IHJlc291cmNlW10pIHsK
IAkJCXsKIAkJCQkuc3RhcnQJPSAweDIzMDAwLApAQCAtMjA2LDYgKzIxNyw3IEBACiAJCS5uYW1l
ID0gImZzbC1laGNpIiwKIAkJLmlkCT0gMiwKIAkJLm51bV9yZXNvdXJjZXMJID0gMiwKKyAgICAg
ICAgICAgICAgICAuZGV2LnBsYXRmb3JtX2RhdGEgPSAmbXBjODN4eF91c2IyX21waF9wZGF0YSwK
IAkJLnJlc291cmNlID0gKHN0cnVjdCByZXNvdXJjZVtdKSB7CiAJCQl7CiAJCQkJLnN0YXJ0CT0g
MHgyMjAwMCwK

--Multipart=_Mon__22_Jan_2007_18_10_27_+0100_VPLYgvx7vPSr7kQI--
