From: Kevin Hendricks <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Paul Mackerras <paulus@linuxcare.com>
Subject: Patch to fix imps2 emulation for usb mice in stable 2.2.X series
Date: Sat, 4 Mar 2000 09:09:54 -0500
Content-Type: Multipart/Mixed;
  boundary="Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD"
Cc: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Message-Id: <00030409183800.00482@localhost.localdomain>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD
Content-Type: text/plain
Content-Transfer-Encoding: 8bit

Hi Paul,

According to the XFree 4.0 developers bit 3 in the first character from all
imps/2 mice must be set.  This was not the case in early 2.3.X kernels but this
bug was found and fixed in later 2.3.XX kernels.

The Xfree 4.0 Xserver uses this fact to determine if characters read from a
imps/2 mouse are out-of-sync or not.

Because our 2.2.X kernel usb mouse.c code never properly sets this bit in the
first character, the XFree 4.0 Xservers are throwing out the first character
read from the mouse umaking for mouse mayhem.

Will you please install this patch into the 2.2.X stable kernel series?  It
will make our imps2 usb mouse properly follow the conventions for imps2 mice
and make it more like what the 2.3.XX kernels are doing right now

I have tried this patch with the latest XFree 3.9.18 Xserver, and with Xpmac
(rev 9) and an older Mac-On-Linux and it does not cause any problems.

Thanks.

Kevin


--- drivers/usb/mouse.c.prev	Fri Mar  3 17:18:37 2000
+++ drivers/usb/mouse.c	Fri Mar  3 17:19:56 2000
@@ -183,6 +183,7 @@
 		switch (state) {
 		case 0: { /* buttons and sign */
 			int buttons = mouse->buttons;
+                        buttons = buttons | 0x08; // set bit 3 to fit imps/2
 			mouse->buttons = 0;
 			if (mouse->dx < 0)
 				buttons |= 0x10;


p.s. In case the e-mail mangles this, I have attached the patch as a file also.

Thanks,

Kevin


--
Kevin B. Hendricks
Associate Professor of Operations and Information Technology
Richard Ivey School of Business, University of Western Ontario
London, Ontario  N6A-3K7  CANADA
khendricks@ivey.uwo.ca, (519) 661-3874, fax: 519-661-3959


--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD
Content-Type: text/x-c++;
  name="usb_imps2.patch"
Content-Disposition: attachment; filename="usb_imps2.patch"
Content-Transfer-Encoding: base64

LS0tIGRyaXZlcnMvdXNiL21vdXNlLmMucHJldglGcmkgTWFyICAzIDE3OjE4OjM3IDIwMDAKKysr
IGRyaXZlcnMvdXNiL21vdXNlLmMJRnJpIE1hciAgMyAxNzoxOTo1NiAyMDAwCkBAIC0xODMsNiAr
MTgzLDcgQEAKIAkJc3dpdGNoIChzdGF0ZSkgewogCQljYXNlIDA6IHsgLyogYnV0dG9ucyBhbmQg
c2lnbiAqLwogCQkJaW50IGJ1dHRvbnMgPSBtb3VzZS0+YnV0dG9uczsKKyAgICAgICAgICAgICAg
ICAgICAgICAgIGJ1dHRvbnMgPSBidXR0b25zIHwgMHgwODsgLy8gc2V0IGJpdCAzIHRvIGZpdCBp
bXBzLzIKIAkJCW1vdXNlLT5idXR0b25zID0gMDsKIAkJCWlmIChtb3VzZS0+ZHggPCAwKQogCQkJ
CWJ1dHRvbnMgfD0gMHgxMDsK

--Boundary-=_nWlrBbmQBhCDarzOwKkYHIDdqSCD--

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
