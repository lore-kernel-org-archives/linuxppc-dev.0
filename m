Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="==_Boundary-1_=="
Date: Mon, 11 Jan 1999 20:50:11 +0100
To: linuxppc-dev@lists.linuxppc.org
CC: Cort Dougan <cort@ladron.cs.nmt.edu>,
        Paul Mackerras <paulus@cs.anu.edu.au>
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: PowerBook ZIP patch
Message-Id: <19990111205011.003224@mail.mipsys.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--==_Boundary-1_==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

The following patch enables the PowerBook internal ZIP drive. You may
need my other patch to irq.c that fixes bogus interrupt values for the
left bay to work (should be included in Cort's new irq.c when finished).
The right bay should work "as is".


--- linux.orig/drivers/block/ide-probe.c	Thu Jan  7 14:17:32 1999
+++ linux.dev/drivers/block/ide-probe.c	Mon Jan 11 22:44:52 1999
@@ -118,8 +118,14 @@
 				}
 				type = ide_cdrom;	/* Early cdrom models used zero */
 			case ide_cdrom:
-				printk ("CDROM");
 				drive->removable = 1;
+				/* XXX kludge for Apple PowerBook internal zip */
+				if (!strstr(id->model, "CD-ROM") && strstr(id->model, "ZIP")) {
+					printk ("FLOPPY");
+					type = ide_floppy;
+					break;
+				}
+				printk ("CDROM");
 				break;
 			case ide_tape:
 				printk ("TAPE");


-- 
           E-Mail: <mailto:bh40@calva.net>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>



--==_Boundary-1_==
Mime-Version: 1.0
Content-Type: application/octet-stream; name="zip.patch"; x-mac-creator="43574945"; x-mac-type="54455854"
Message-Id: <19990111205023.028569>
Date: Mon, 11 Jan 1999 20:50:23 +0100
Content-Transfer-Encoding: base64

LS0tIGxpbnV4Lm9yaWcvZHJpdmVycy9ibG9jay9pZGUtcHJvYmUuYwlUaHUgSmFu
ICA3IDE0OjE3OjMyIDE5OTkKKysrIGxpbnV4LmRldi9kcml2ZXJzL2Jsb2NrL2lk
ZS1wcm9iZS5jCU1vbiBKYW4gMTEgMjI6NDQ6NTIgMTk5OQpAQCAtMTE4LDggKzEx
OCwxNCBAQAogCQkJCX0KIAkJCQl0eXBlID0gaWRlX2Nkcm9tOwkvKiBFYXJseSBj
ZHJvbSBtb2RlbHMgdXNlZCB6ZXJvICovCiAJCQljYXNlIGlkZV9jZHJvbToKLQkJ
CQlwcmludGsgKCJDRFJPTSIpOwogCQkJCWRyaXZlLT5yZW1vdmFibGUgPSAxOwor
CQkJCS8qIFhYWCBrbHVkZ2UgZm9yIEFwcGxlIFBvd2VyQm9vayBpbnRlcm5hbCB6
aXAgKi8KKwkJCQlpZiAoIXN0cnN0cihpZC0+bW9kZWwsICJDRC1ST00iKSAmJiBz
dHJzdHIoaWQtPm1vZGVsLCAiWklQIikpIHsKKwkJCQkJcHJpbnRrICgiRkxPUFBZ
Iik7CisJCQkJCXR5cGUgPSBpZGVfZmxvcHB5OworCQkJCQlicmVhazsKKwkJCQl9
CisJCQkJcHJpbnRrICgiQ0RST00iKTsKIAkJCQlicmVhazsKIAkJCWNhc2UgaWRl
X3RhcGU6CiAJCQkJcHJpbnRrICgiVEFQRSIpOwo=

--==_Boundary-1_==--


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
