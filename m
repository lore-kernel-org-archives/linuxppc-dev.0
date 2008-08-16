Return-Path: <mazsi@imrek.org>
Received: from mail.imrek.org (mail.imrek.org [67.207.130.102])
	by ozlabs.org (Postfix) with ESMTP id 9330EDDDE6
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 17 Aug 2008 08:02:01 +1000 (EST)
Received: from mail.imrek.org ([67.207.130.102])
	by mail.imrek.org with esmtp (Exim 4.63)
	(envelope-from <mazsi@imrek.org>) id 1KUTPG-0002Tp-Qt
	for linuxppc-embedded@ozlabs.org; Sat, 16 Aug 2008 23:33:54 +0200
Date: Sat, 16 Aug 2008 23:33:54 +0200 (CEST)
From: jozsef imrek <mazsi@imrek.org>
To: linuxppc-embedded@ozlabs.org
Subject: Re: U-boot and Xilinx emaclite, TX_PING_PONG -> stops working
In-Reply-To: <48A7302F.8030707@hachti.de>
Message-ID: <Pine.LNX.4.64.0808162240010.9518@mail.imrek.org>
References: <931ae8260808160434g1ff6d856n46e5e420e487db57@mail.gmail.com>
	<48A7302F.8030707@hachti.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-817666430-372881881-1218922434=:9518"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---817666430-372881881-1218922434=:9518
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed


dear philipp,


On Sat, 16 Aug 2008, Philipp Hachtmann wrote:

> I am currently wondering if someone has experience with the emaclite
> driver. When I unset the "ping pong" (double buffering) parameters of
> ...
>
> I found a driver (xilinx_emaclite.c) in the U-boot git. That completely
> refuses to work correctly (of course with parameters corrected). The
> other driver I once found "somewhere" (in the Petalinux distribution).

i don't know what exact versions are you using. for me the following
combination works reasonably both with tx-ping-pong = rx-ping-pong = 0
and with tx-ping-pong = rx-ping-pong = 1, both under u-boot and
linux (i'm normally using ping-pong = 1, i've only made a quick test
with ping-pong = 0):

- edk 9.1, opb_ethernetlite v1.01.b, v4-fx12 (memec/avnet minimodule)
- u-boot: ftp://ftp.denx.de/pub/u-boot/u-boot-1.3.3.tar.bz2
- linux: xilinx's git://git.xilinx.com/linux-2.6-xlnx, 2.6.26-rc6


also, i think there is a bug in the linux driver: the XEmacLite_Config
structure used to set up the device is located on the stack. so
after the init returns, further references to this struct by the
os independent part of the driver are invalid. see the attached
patch. i don't know if it solves your prolem, though..

(the patch also replaces a few calls of dev_kfree_skb() from
interrupt context. thoose can generate lots of warnings on the
console, thus slowing down operation.)


-- 
mazsi

----------------------------------------------------------------
strawberry fields forever!                       mazsi@imrek.org
----------------------------------------------------------------
---817666430-372881881-1218922434=:9518
Content-Type: TEXT/x-diff; charset=US-ASCII; name=emaclite-init.patch
Content-Transfer-Encoding: BASE64
Content-ID: <Pine.LNX.4.64.0808162333540.9518@mail.imrek.org>
Content-Description: 
Content-Disposition: attachment; filename=emaclite-init.patch

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3hpbGlueF9lbWFjbGl0ZS9hZGFw
dGVyLmMgYi9kcml2ZXJzL25ldC94aWxpbnhfZW1hY2xpdGUvYWRhcHRlci5j
DQppbmRleCBlZDdhOTQ3Li4yYTUwZTI5IDEwMDY0NA0KLS0tIGEvZHJpdmVy
cy9uZXQveGlsaW54X2VtYWNsaXRlL2FkYXB0ZXIuYw0KKysrIGIvZHJpdmVy
cy9uZXQveGlsaW54X2VtYWNsaXRlL2FkYXB0ZXIuYw0KQEAgLTEwMCw2ICsx
MDAsNyBAQCBzdHJ1Y3QgbmV0X2xvY2FsIHsNCiAJICogZGF0YSBhcyBhbiBv
cGFxdWUgb2JqZWN0IGluIHRoaXMgZmlsZSAobWVhbmluZyB0aGF0IHdlIG5l
dmVyDQogCSAqIHJlZmVyZW5jZSBhbnkgb2YgdGhlIGZpZWxkcyBpbnNpZGUg
b2YgdGhlIHN0cnVjdHVyZSkuDQogCSAqLw0KKwlYRW1hY0xpdGVfQ29uZmln
IENvbmZpZzsNCiAJWEVtYWNMaXRlIEVtYWNMaXRlOw0KIA0KIAl2b2lkICpk
ZXNjX3NwYWNlOw0KQEAgLTE2OCw3ICsxNjksNyBAQCBzdGF0aWMgdm9pZCBy
ZXNldChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LCBEVVBMRVggZHVwbGV4KQ0K
IAlYRW1hY0xpdGVfRW5hYmxlSW50ZXJydXB0cygmbHAtPkVtYWNMaXRlKTsN
CiANCiAJaWYgKGxwLT5kZWZlcnJlZF9za2IpIHsNCi0JCWRldl9rZnJlZV9z
a2IobHAtPmRlZmVycmVkX3NrYik7DQorCQlkZXZfa2ZyZWVfc2tiX2FueShs
cC0+ZGVmZXJyZWRfc2tiKTsNCiAJCWxwLT5kZWZlcnJlZF9za2IgPSBOVUxM
Ow0KIAkJbHAtPnN0YXRzLnR4X2Vycm9ycysrOw0KIAl9DQpAQCAtMjc5LDcg
KzI4MCw3IEBAIHN0YXRpYyBpbnQgeGVtYWNsaXRlX1NlbmQoc3RydWN0IHNr
X2J1ZmYgKm9yaWdfc2tiLCBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQ0KIAlz
cGluX3VubG9ja19pcnFyZXN0b3JlKCZyZXNldF9sb2NrLCBmbGFncyk7DQog
DQogCWxwLT5zdGF0cy50eF9ieXRlcyArPSBsZW47DQotCWRldl9rZnJlZV9z
a2IobmV3X3NrYik7DQorCWRldl9rZnJlZV9za2JfYW55KG5ld19za2IpOw0K
IAlkZXYtPnRyYW5zX3N0YXJ0ID0gamlmZmllczsNCiANCiAJcmV0dXJuIDA7
DQpAQCAtMjk4LDcgKzI5OSw3IEBAIHN0YXRpYyB2b2lkIFNlbmRIYW5kbGVy
KHZvaWQgKkNhbGxiYWNrUmVmKQ0KIAkJCXJldHVybjsNCiAJCX0NCiAJCWVs
c2Ugew0KLQkJCWRldl9rZnJlZV9za2IobHAtPmRlZmVycmVkX3NrYik7DQor
CQkJZGV2X2tmcmVlX3NrYl9hbnkobHAtPmRlZmVycmVkX3NrYik7DQogCQkJ
bHAtPmRlZmVycmVkX3NrYiA9IE5VTEw7DQogCQkJbmV0aWZfd2FrZV9xdWV1
ZShkZXYpOw0KIAkJfQ0KQEAgLTM1NCw3ICszNTUsNyBAQCBzdGF0aWMgdm9p
ZCBSZWN2SGFuZGxlcih2b2lkICpDYWxsYmFja1JlZikNCiAJaWYgKCFsZW4p
IHsNCiANCiAJCWxwLT5zdGF0cy5yeF9lcnJvcnMrKzsNCi0JCWRldl9rZnJl
ZV9za2Ioc2tiKTsNCisJCWRldl9rZnJlZV9za2JfYW55KHNrYik7DQogCQkv
L3ByaW50ayhLRVJOX0VSUiAiJXM6IENvdWxkIG5vdCByZWNlaXZlIGJ1ZmZl
clxuIixkZXYtPm5hbWUpOw0KIAkJc3Bpbl9sb2NrKCZyZXNldF9sb2NrKTsN
CiAJCS8vcmVzZXQoZGV2LCBVTktOT1dOX0RVUExFWCk7DQpAQCAtNDM4LDgg
KzQzOSw2IEBAIHN0YXRpYyBpbnQgeGVtYWNsaXRlX3NldHVwKA0KIA0KIAl1
MzIgdmlydF9iYWRkcjsJCS8qIHZpcnR1YWwgYmFzZSBhZGRyZXNzIG9mIGVt
YWMgKi8NCiANCi0JWEVtYWNMaXRlX0NvbmZpZyBDb25maWc7DQotDQogCXN0
cnVjdCBuZXRfZGV2aWNlICpuZGV2ID0gTlVMTDsNCiAJc3RydWN0IG5ldF9s
b2NhbCAqbHAgPSBOVUxMOw0KIA0KQEAgLTQ3MSw5ICs0NzAsOSBAQCBzdGF0
aWMgaW50IHhlbWFjbGl0ZV9zZXR1cCgNCiAJbHAtPm5kZXYgPSBuZGV2Ow0K
IA0KIAkvKiBTZXR1cCB0aGUgQ29uZmlnIHN0cnVjdHVyZSBmb3IgdGhlIFhF
bWFjTGl0ZV9DZmdJbml0aWFsaXplKCkgY2FsbC4gKi8NCi0JQ29uZmlnLkJh
c2VBZGRyZXNzCT0gcl9tZW0tPnN0YXJ0OwkvKiBQaHlzaWNhbCBhZGRyZXNz
ICovDQotCUNvbmZpZy5UeFBpbmdQb25nCT0gcGRhdGEtPnR4X3BpbmdfcG9u
ZzsNCi0JQ29uZmlnLlJ4UGluZ1BvbmcJPSBwZGF0YS0+cnhfcGluZ19wb25n
Ow0KKwlscC0+Q29uZmlnLkJhc2VBZGRyZXNzCT0gcl9tZW0tPnN0YXJ0Owkv
KiBQaHlzaWNhbCBhZGRyZXNzICovDQorCWxwLT5Db25maWcuVHhQaW5nUG9u
Zwk9IHBkYXRhLT50eF9waW5nX3Bvbmc7DQorCWxwLT5Db25maWcuUnhQaW5n
UG9uZwk9IHBkYXRhLT5yeF9waW5nX3Bvbmc7DQogDQogDQogCS8qIEdldCB0
aGUgdmlydHVhbCBiYXNlIGFkZHJlc3MgZm9yIHRoZSBkZXZpY2UgKi8NCkBA
IC00ODUsNyArNDg0LDcgQEAgc3RhdGljIGludCB4ZW1hY2xpdGVfc2V0dXAo
DQogCX0NCiANCiANCi0JaWYgKFhFbWFjTGl0ZV9DZmdJbml0aWFsaXplKCZs
cC0+RW1hY0xpdGUsICZDb25maWcsIHZpcnRfYmFkZHIpICE9IFhTVF9TVUND
RVNTKSB7DQorCWlmIChYRW1hY0xpdGVfQ2ZnSW5pdGlhbGl6ZSgmbHAtPkVt
YWNMaXRlLCAmbHAtPkNvbmZpZywgdmlydF9iYWRkcikgIT0gWFNUX1NVQ0NF
U1MpIHsNCiAJCWRldl9lcnIoZGV2LCAiWEVtYWNMaXRlOiBDb3VsZCBub3Qg
aW5pdGlhbGl6ZSBkZXZpY2UuXG4iKTsNCiAJCXJjID0gLUVOT0RFVjsNCiAJ
CWdvdG8gZXJyb3I7DQpAQCAtNDk4LDEyICs0OTcsMTIgQEAgc3RhdGljIGlu
dCB4ZW1hY2xpdGVfc2V0dXAoDQogICAgICAgICBYRW1hY0xpdGVfU2V0TWFj
QWRkcmVzcygmbHAtPkVtYWNMaXRlLCBuZGV2LT5kZXZfYWRkcik7DQogDQog
CWRldl9pbmZvKGRldiwNCi0JCQkiTUFDIGFkZHJlc3MgaXMgbm93ICUyeDol
Mng6JTJ4OiUyeDolMng6JTJ4XG4iLA0KKwkJCSJNQUMgYWRkcmVzcyBpcyBu
b3cgJTAyeDolMDJ4OiUwMng6JTAyeDolMDJ4OiUwMnhcbiIsDQogCQkJcGRh
dGEtPm1hY19hZGRyWzBdLCBwZGF0YS0+bWFjX2FkZHJbMV0sDQogCQkJcGRh
dGEtPm1hY19hZGRyWzJdLCBwZGF0YS0+bWFjX2FkZHJbM10sDQogCQkJcGRh
dGEtPm1hY19hZGRyWzRdLCBwZGF0YS0+bWFjX2FkZHJbNV0pOw0KIA0KLQlk
ZXZfZXJyKGRldiwgInVzaW5nIGZpZm8gbW9kZS5cbiIpOw0KKwlkZXZfZXJy
KGRldiwgInVzaW5nIGZpZm8gbW9kZSwgdHgtcGluZy1wb25nPSVkLCByeC1w
aW5nLXBvbmc9JWQuXG4iLCBscC0+Q29uZmlnLlR4UGluZ1BvbmcsIGxwLT5D
b25maWcuUnhQaW5nUG9uZyk7DQogCVhFbWFjTGl0ZV9TZXRSZWN2SGFuZGxl
cigmbHAtPkVtYWNMaXRlLCBuZGV2LCBSZWN2SGFuZGxlcik7DQogCVhFbWFj
TGl0ZV9TZXRTZW5kSGFuZGxlcigmbHAtPkVtYWNMaXRlLCBuZGV2LCBTZW5k
SGFuZGxlcik7DQogCW5kZXYtPmhhcmRfc3RhcnRfeG1pdCA9IHhlbWFjbGl0
ZV9TZW5kOw0K

---817666430-372881881-1218922434=:9518--
