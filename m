Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="==_Boundary-1_=="
Date: Wed, 15 Sep 1999 16:35:54 +0200
To: linuxppc-dev@lists.linuxppc.org, Paul.Mackerras@cs.anu.edu.au
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: Sleep fix
Message-Id: <19990915163554.003512@mailhost.mipsys.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


--==_Boundary-1_==
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Here's a fix for a hang when sleeping on some wallstreet revisions:

--- linux.orig/drivers/video/atyfb.c	Thu Sep  2 02:34:39 1999
+++ linux/drivers/video/atyfb.c	Wed Sep 15 16:28:01 1999
@@ -3922,13 +3922,15 @@
 			/* Stop accel engine (stop bus mastering) */
 			if (info->current_par.accel_flags & FB_ACCELF_TEXT)
 				reset_engine(info);
-#if 1
-			/* Backup fb content */	
+	
+			/* Backup fb content (apparently only required for some
+			   chips, we keep it like this for now)
+			 */	
 			info->save_framebuffer = vmalloc(nb);
 			if (info->save_framebuffer)
 				memcpy(info->save_framebuffer,
 				       (void *)info->frame_buffer, nb);
-#endif
+
 			/* Blank display and LCD */				       
 			atyfbcon_blank(VESA_POWERDOWN+1, (struct fb_info *)info);			
 			
@@ -3950,6 +3952,11 @@
 				aty_st_le32(POWER_MANAGEMENT, pm, info);
 				do {
 					pm = aty_ld_le32(POWER_MANAGEMENT, info);
+					/* There's apparently a problem with the chip ID 4c50
+                                           here's a temp fix until ATI
gives me a definitive
+                                           answer. --BenH */
+					if (Gx == LP_CHIP_ID)
+					    break;
 				} while ((pm & PWR_MGT_STATUS_MASK) != PWR_MGT_STATUS_SUSPEND);
 				mdelay(500);
 			}
@@ -3969,10 +3976,12 @@
 				aty_st_le32(POWER_MANAGEMENT, pm, info);
 				do {
 					pm = aty_ld_le32(POWER_MANAGEMENT, info);
+					if (Gx == LP_CHIP_ID)
+					    break;
 				} while ((pm & PWR_MGT_STATUS_MASK) != 0);
 				mdelay(500);
 			}
-#if 1
+
 			/* Restore fb content */			
 			if (info->save_framebuffer) {
 				memcpy((void *)info->frame_buffer,
@@ -3980,7 +3989,7 @@
 				vfree(info->save_framebuffer);
 				info->save_framebuffer = 0;
 			}
-#endif
+
 			/* Restore display */			
 			atyfb_set_par(&info->current_par, info);
 			atyfbcon_blank(0, (struct fb_info *)info);


-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>


--==_Boundary-1_==
Mime-Version: 1.0
Content-Type: application/octet-stream; name="aty_sleep.diff"; x-mac-creator="43574945"; x-mac-type="54455854"
Message-Id: <19990915163604.027156>
Date: Wed, 15 Sep 1999 16:36:04 +0200
Content-Transfer-Encoding: base64

LS0tIGxpbnV4Lm9yaWcvZHJpdmVycy92aWRlby9hdHlmYi5jCVRodSBTZXAgIDIg
MDI6MzQ6MzkgMTk5OQorKysgbGludXgvZHJpdmVycy92aWRlby9hdHlmYi5jCVdl
ZCBTZXAgMTUgMTY6Mjg6MDEgMTk5OQpAQCAtMzkyMiwxMyArMzkyMiwxNSBAQAog
CQkJLyogU3RvcCBhY2NlbCBlbmdpbmUgKHN0b3AgYnVzIG1hc3RlcmluZykgKi8K
IAkJCWlmIChpbmZvLT5jdXJyZW50X3Bhci5hY2NlbF9mbGFncyAmIEZCX0FDQ0VM
Rl9URVhUKQogCQkJCXJlc2V0X2VuZ2luZShpbmZvKTsKLSNpZiAxCi0JCQkvKiBC
YWNrdXAgZmIgY29udGVudCAqLwkKKwkKKwkJCS8qIEJhY2t1cCBmYiBjb250ZW50
IChhcHBhcmVudGx5IG9ubHkgcmVxdWlyZWQgZm9yIHNvbWUKKwkJCSAgIGNoaXBz
LCB3ZSBrZWVwIGl0IGxpa2UgdGhpcyBmb3Igbm93KQorCQkJICovCQogCQkJaW5m
by0+c2F2ZV9mcmFtZWJ1ZmZlciA9IHZtYWxsb2MobmIpOwogCQkJaWYgKGluZm8t
PnNhdmVfZnJhbWVidWZmZXIpCiAJCQkJbWVtY3B5KGluZm8tPnNhdmVfZnJhbWVi
dWZmZXIsCiAJCQkJICAgICAgICh2b2lkICopaW5mby0+ZnJhbWVfYnVmZmVyLCBu
Yik7Ci0jZW5kaWYKKwogCQkJLyogQmxhbmsgZGlzcGxheSBhbmQgTENEICovCQkJ
CSAgICAgICAKIAkJCWF0eWZiY29uX2JsYW5rKFZFU0FfUE9XRVJET1dOKzEsIChz
dHJ1Y3QgZmJfaW5mbyAqKWluZm8pOwkJCQogCQkJCkBAIC0zOTUwLDYgKzM5NTIs
MTEgQEAKIAkJCQlhdHlfc3RfbGUzMihQT1dFUl9NQU5BR0VNRU5ULCBwbSwgaW5m
byk7CiAJCQkJZG8gewogCQkJCQlwbSA9IGF0eV9sZF9sZTMyKFBPV0VSX01BTkFH
RU1FTlQsIGluZm8pOworCQkJCQkvKiBUaGVyZSdzIGFwcGFyZW50bHkgYSBwcm9i
bGVtIHdpdGggdGhlIGNoaXAgSUQgNGM1MAorICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGhlcmUncyBhIHRlbXAgZml4IHVudGlsIEFU
SSBnaXZlcyBtZSBhIGRlZmluaXRpdmUKKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBhbnN3ZXIuIC0tQmVuSCAqLworCQkJCQlpZiAo
R3ggPT0gTFBfQ0hJUF9JRCkKKwkJCQkJICAgIGJyZWFrOwogCQkJCX0gd2hpbGUg
KChwbSAmIFBXUl9NR1RfU1RBVFVTX01BU0spICE9IFBXUl9NR1RfU1RBVFVTX1NV
U1BFTkQpOwogCQkJCW1kZWxheSg1MDApOwogCQkJfQpAQCAtMzk2OSwxMCArMzk3
NiwxMiBAQAogCQkJCWF0eV9zdF9sZTMyKFBPV0VSX01BTkFHRU1FTlQsIHBtLCBp
bmZvKTsKIAkJCQlkbyB7CiAJCQkJCXBtID0gYXR5X2xkX2xlMzIoUE9XRVJfTUFO
QUdFTUVOVCwgaW5mbyk7CisJCQkJCWlmIChHeCA9PSBMUF9DSElQX0lEKQorCQkJ
CQkgICAgYnJlYWs7CiAJCQkJfSB3aGlsZSAoKHBtICYgUFdSX01HVF9TVEFUVVNf
TUFTSykgIT0gMCk7CiAJCQkJbWRlbGF5KDUwMCk7CiAJCQl9Ci0jaWYgMQorCiAJ
CQkvKiBSZXN0b3JlIGZiIGNvbnRlbnQgKi8JCQkKIAkJCWlmIChpbmZvLT5zYXZl
X2ZyYW1lYnVmZmVyKSB7CiAJCQkJbWVtY3B5KCh2b2lkICopaW5mby0+ZnJhbWVf
YnVmZmVyLApAQCAtMzk4MCw3ICszOTg5LDcgQEAKIAkJCQl2ZnJlZShpbmZvLT5z
YXZlX2ZyYW1lYnVmZmVyKTsKIAkJCQlpbmZvLT5zYXZlX2ZyYW1lYnVmZmVyID0g
MDsKIAkJCX0KLSNlbmRpZgorCiAJCQkvKiBSZXN0b3JlIGRpc3BsYXkgKi8JCQkK
IAkJCWF0eWZiX3NldF9wYXIoJmluZm8tPmN1cnJlbnRfcGFyLCBpbmZvKTsKIAkJ
CWF0eWZiY29uX2JsYW5rKDAsIChzdHJ1Y3QgZmJfaW5mbyAqKWluZm8pOwo=

--==_Boundary-1_==--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
