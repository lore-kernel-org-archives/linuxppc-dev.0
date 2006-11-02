Return-Path: <rdcorle@yahoo.com>
Received: from web56312.mail.re3.yahoo.com (web56312.mail.re3.yahoo.com
	[216.252.110.236]) by ozlabs.org (Postfix) with SMTP id 64A9767CC8
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Nov 2006 09:20:43 +1100 (EST)
Message-ID: <20061102222041.16498.qmail@web56312.mail.re3.yahoo.com>
Date: Thu, 2 Nov 2006 14:20:41 -0800 (PST)
From: robert corley <rdcorle@yahoo.com>
Subject: minor progress with plb_temac v3.00a, EDK 8.2, & 2.6.18.1
To: linux linuxppc-embedded <linuxppc-embedded@ozlabs.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="0-1958789053-1162506041=:14180"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--0-1958789053-1162506041=:14180
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: quoted-printable

For those interested, I have acheived some measure of success with the plb_=
temac driver.=0A=0AI have attached a txt file of what I had to do to get it=
 working under 2.6.18.1=0A=0AI am using the plb_temac in DMA mode 3=0A=0ABe=
low you will see the boot dump.=0A=0AFor those able to help, can anyone pro=
vide insight as to the failure of setting PHY link speed?=0A=0A-cy=0A=0A=0A=
=0A=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=0A---------=
-------------------------------------------------------------=0A2.6.18.1 ke=
rnel with all patches=0A11/02/2006    15:30=0Aplb_temac v3.00a=0Ahard_temac=
 v3.00b=0A=0A=0Aloaded at:     00400000 009F1138=0Aboard data at: 009EF120 =
009EF138=0Arelocated to:  004040B4 004040CC=0Azimage at:     00404EC7 0057C=
1F2=0Ainitrd at:     0057D000 009EE6FE=0Aavail ram:     009F2000 04000000=
=0A=0A=0ALinux/PPC load: console=3DttyUL0 single ip=3D192.168.1.100:192.168=
.1.144:192.168.1.1:255.255.255.0:nab:: ramdisk_size=3D4660000 root=3D/dev/r=
am rw=0A=0AUncompressing Linux...done.=0A=0ANow booting the kernel=0A=0A[  =
  0.000000] Linux version 2.6.18.1 (rdcorle@athena) (gcc version 3.4.2) #2 =
Thu Nov 2 21:56:32 UTC 2006=0A[    0.000000] Xilinx ML403 Reference System =
(Virtex-4 FX)=0A[    0.000000] Built 1 zonelists.  Total pages: 16384=0A[  =
  0.000000] Kernel command line: console=3DttyUL0 single ip=3D192.168.1.100=
:192.168.1.144:192.168.1.1:255.255.255.0:nab:: ramdisk_size=3D4660000 root=
=3D/dev/ram rw=0A[    0.000000] Xilinx INTC #0 at 0xD1000FC0 mapped to 0xFD=
FFFFC0=0A[    0.000000] PID hash table entries: 512 (order: 9, 2048 bytes)=
=0A[    0.000158] Console: colour dummy device 80x25=0A[    0.000568] Dentr=
y cache hash table entries: 8192 (order: 3, 32768 bytes)=0A[    0.001277] I=
node-cache hash table entries: 4096 (order: 2, 16384 bytes)=0A[    0.012895=
] Memory: 57060k available (2548k kernel code, 640k data, 96k init, 0k high=
mem)=0A[    0.104378] Mount-cache hash table entries: 512=0A[    0.106721] =
checking if image is initramfs...it isn't (no cpio magic); looks like an in=
itrd=0A[    2.414242] Freeing initrd memory: 4549k freed=0A[    2.418712] N=
ET: Registered protocol family 16=0A[    2.427313] NET: Registered protocol=
 family 2=0A[    2.464244] IP route cache hash table entries: 512 (order: -=
1, 2048 bytes)=0A[    2.465037] TCP established hash table entries: 2048 (o=
rder: 1, 8192 bytes)=0A[    2.465205] TCP bind hash table entries: 1024 (or=
der: 0, 4096 bytes)=0A[    2.465296] TCP: Hash tables configured (establish=
ed 2048 bind 1024)=0A[    2.465324] TCP reno registered=0A[    2.474633] NT=
FS driver 2.1.27 [Flags: R/O].=0A[    2.475046] JFS: nTxBlock =3D 481, nTxL=
ock =3D 3854=0A[    2.477623] SGI XFS with no debug enabled=0A[    2.479001=
] io scheduler noop registered=0A[    2.479109] io scheduler anticipatory r=
egistered=0A[    2.479197] io scheduler deadline registered=0A[    2.479402=
] io scheduler cfq registered (default)=0A[    2.517627] uartlite.0: ttyUL0=
 at MMIO 0xa0000000 (irq =3D 1) is a uartlite=0A[    2.691029] RAMDISK driv=
er initialized: 16 RAM disks of 4660000K size 1024 blocksize=0A[    2.70393=
3] loop: loaded (max 8 devices)=0A[    2.709698] XTemac: using sgDMA mode.=
=0A[    2.713493] XTemac: using TxDRE mode=0A[    2.717081] XTemac: using R=
xDRE mode=0A[    2.720678] XTemac: buffer descriptor size: 32768 (0x8000)=
=0A[    2.726622] XTemac: (buffer_descriptor_init) phy: 0x580000, virt: 0xf=
f100000, size: 0x8000=0A[    2.741073] eth0: Xilinx TEMAC #0 at 0x60000000 =
mapped to 0xC5050000, irq=3D0=0A[    2.748080] eth0: XTemac id 1.0f, block =
id 5, type 8=0A[    2.753636] mice: PS/2 mouse device common for all mice=
=0A[    2.759529] TCP bic registered=0A[    3.264317] eth0: XTemac: Options=
: 0xb8f2=0A[   15.227339] eth0: XTemac: Not able to set the speed to 1000 (=
status: 0x148)=0A[   25.200394] eth0: XTemac: Not able to set the speed to =
100 (status: 0x148)=0A[   35.173357] eth0: XTemac: Not able to set the spee=
d to 10 (status: 0x148)=0A[   35.180122] eth0: XTemac: could not negotiate =
speed=0A[   35.187740] eth0: XTemac: Send Threshold =3D 16, Receive Thresho=
ld =3D 2=0A[   35.194116] eth0: XTemac: Send Wait bound =3D 1, Receive Wait=
 bound =3D 1=0A[   36.205399] IP-Config: Complete:=0A[   36.208459]       d=
evice=3Deth0, addr=3D192.168.1.100, mask=3D255.255.255.0, gw=3D192.168.1.1,=
=0A[   36.216339]      host=3Dnab, domain=3D, nis-domain=3D(none),=0A[   36=
.221487]      bootserver=3D192.168.1.144, rootserver=3D192.168.1.144, rootp=
ath=3D=0A[   36.229826] RAMDISK: Compressed image found at block 0=0A[   37=
.200498] eth0: XTemac: PHY Link carrier lost.=0A[   39.097820] VFS: Mounted=
 root (ext2 filesystem).=0A[   39.102751] Freeing unused kernel memory: 96k=
 init=0A[   39.108356] ulite_startup: UART status =3D 0x0014=0A[   39.12461=
9] ulite_startup: UART status =3D 0x0014=0A[   39.134313] ulite_startup: UA=
RT status =3D 0x0014=0A=0A=0ABusyBox v1.00-pre9 (2004.04.18-19:53+0000) Bui=
lt-in shell (ash)=0AEnter 'help' for a list of built-in commands.=0A=0A-sh:=
 can't access tty; job control turned off=0A=0A=0A
--0-1958789053-1162506041=:14180
Content-Type: text/plain; name="=?utf-8?q?kernel=202.6.18=20and=20the=20plb=5Ftemac.txt?="
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="=?utf-8?q?kernel=202.6.18=20and=20the=20plb=5Ftemac.txt?="

c3RlcHMgZm9yIHBsYl90ZW1hYyBkcml2ZXJzIHVuZGVyIEVESyA4LjIuMDJp
ICh3L1NQMi40KzApDQpVc2luZyBwbGJfdGVtYWMgdjMuMDBhICYgaGFyZF90
ZW1hYyB2My4wMGINCg0KR2VuZXJhdGUgcy93IGxpYnJhcmllcw0KDQoxLglj
b3B5IG9yIGZ0cCB0aGUgZm9sbG93aW5nIGZpbGVzIGZyb20gQzpcRURLXHN3
XFRoaXJkUGFydHlcYnNwXGxpbnV4XzJfNl92MV8wMF9hXGxpbnV4XA0KCXRv
IHRoZSBiYXNlIGRpcmVjdG9yeSBvZiB0aGUgbGludXggc291cmNlIHRyZWUN
Cg0KCVVTRUQ6DQoJYXJjaFxwcGNccGxhdGZvcm1zXDR4eFx4cGFyYW1ldGVy
c1x4cGFyYW1ldGVycy5oDQoNCgkqKiBVTlVTRUQNCglhcmNoXHBwY1xwbGF0
Zm9ybXNcNHh4XHZpcnRleC5jDQoJYXJjaFxwcGNcYm9vdFxzaW1wbGVcZW1i
ZWRfY29uZmlnLmMNCglpbmNsdWRlXGxpbnV4XHhpbGlueF9kZXZpY2VzLmgN
Cg0KMi4JY29weSBDOlxFREtcc3dcVGhpcmRQYXJ0eVxic3BcbGludXhfMl82
X3YxXzAwX2FcZHJpdmVyc1x0ZW1hY19saW51eF8yXzZfdjJfMDBfYlxzcmNc
YWRhcHRlci5jIHRvDQoJLi4vZHJpdmVycy9uZXQveGlsaW54X3RlbWFjL2Fk
YXB0ZXIuYw0KDQozLgljb3B5IG9yIGZ0cCAuLlxsaW51eFxhcmNoXHBwY1xw
bGF0Zm9ybXNceGlsaW54X29jcCA9PiBkcml2ZXJzL3hpbGlueF9lZGsNCglO
b3RlOiBSZW1vdmUgYWxsIG9sZCBmaWxlcyBmaXJzdCAqZXhjZXB0KiBLY29u
ZmlnLCB4aW8uaA0KDQo0Lgltb2RpZnkgZHJpdmVycy94aWxpbnhfZWRrL01h
a2VmaWxlIHdpdGggdGhlIGZvbGxvd2luZyB0byBsb29rIGxpa2UgdGhpczoN
Cg0KIyBMaW51eCBmaWxlIHRvIEVYUE9SVF9TWU1CT0wgYWxsIG9mIHRoZSBY
aWxpbnggZW50cmllcy4NCm9iai0kKENPTkZJR19YSUxJTlhfRURLKSArPSB4
aWxpbnhfc3ltcy5vDQojDQojICMgVGhlIFhpbGlueCBPUyBpbmRlcGVuZGVu
dCBjb2RlLg0KeGlsaW54X3N5bXMtb2JqcyA6PSB4YmFzaWNfdHlwZXMubyBc
DQogICAgICAgICAgICAgICAgICAgIHhkbWF2My5vIHhkbWF2M19pbnRyLm8g
eGRtYXYzX3NlbGZ0ZXN0Lm8geGRtYXYzX3NpbXBsZS5vIHhkbWF2M19zZy5v
IFwNCiAgICAgICAgICAgICAgICAgICAgeGlwaWZfdjFfMjNfYi5vIFwNCiAg
ICAgICAgICAgICAgICAgICAgeHBhY2tldF9maWZvX2xfdjJfMDBfYS5vIHhw
YWNrZXRfZmlmb192Ml8wMF9hLm8gXA0KICAgICAgICAgICAgICAgICAgICB4
dmVyc2lvbi5vDQoNCjUuCU1vZGlmeSB5b3VyIGNvcGllZCB4cGFyYW1ldGVy
c19tbDQwMy5oIChzZWUgbm90ZXMgYmVsb3cpIGFzIGZvbGxvd3M6DQoJYWRk
IHRoZXNlIGxpbmVzIGFmdGVyICNkZWZpbmUgWFBBUl9QTEJfVEVNQUNfMF9J
TkNMVURFX1JYX0NTVU0NCg0KCSNkZWZpbmUgWFBBUl9URU1BQ18wX0lQSUZf
UkRGSUZPX0RFUFRIICBYUEFSX1BMQl9URU1BQ18wX1JYRklGT19ERVBUSA0K
CSNkZWZpbmUgWFBBUl9URU1BQ18wX0lQSUZfV1JGSUZPX0RFUFRIICBYUEFS
X1BMQl9URU1BQ18wX1RYRklGT19ERVBUSA0KCSNkZWZpbmUgWFBBUl9URU1B
Q18wX01BQ19GSUZPX0RFUFRIICAgICBYUEFSX1BMQl9URU1BQ18wX01BQ19G
SUZPX0RFUFRIDQoJI2RlZmluZSBYUEFSX1RFTUFDXzBfVEVNQUNfRENSX0hP
U1QgICAgIDANCgkjZGVmaW5lIFhQQVJfVEVNQUNfMF9JTkNMVURFX0RSRSAg
ICAgICAgMQ0KDQoNCjYuCShvcHRpb25hbCkgbW9kaWZ5IGFyY2gvcHBjL3Bs
YXRmb3Jtcy92aXJ0ZXguaCB0byBhY2NvbW9kYXRlIFJYX0NTVU0gWFBBUg0K
DQpzdHJ1Y3QgeHRlbWFjX3BsYXRmb3JtX2RhdGEgew0KI2lmZGVmIFhQQVJf
VEVNQUNfMF9JTkNMVURFX1JYX0NTVU0NCiAgICAgIHU4IHR4X2RyZTsNCiAg
ICAgIHU4IHJ4X2RyZTsNCiAgICAgIHU4IHR4X2NzdW07DQogICAgICB1OCBy
eF9jc3VtOw0KICAgICAgdTggcGh5X3R5cGU7DQojZW5kaWYNCiAgICAgIHU4
IGRtYV9tb2RlOw0KICAgICAgdTMyIHJ4X3BrdF9maWZvX2RlcHRoOw0KICAg
ICAgdTMyIHR4X3BrdF9maWZvX2RlcHRoOw0KICAgICAgdTE2IG1hY19maWZv
X2RlcHRoOw0KICAgICAgdTggZGNyX2hvc3Q7DQogICAgICB1OCBkcmU7DQog
ICAgICB1OCBtYWNfYWRkcls2XTsNCn07DQoNCjcuCU1vZGlmeSAuLi9kcml2
ZXJzL25ldC94aWxpbnhfdGVtYWMvYWRhcHRlci5jIHRvIHJlbW92ZSAjaW5j
bHVkZSA8bGludXgveGlsaW54X2RldmljZXMuaD4gYW5kDQoJYWRkICNpbmNs
dWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4NCglhZGQgI2luY2x1ZGUg
PHBsYXRmb3Jtcy80eHgvdmlydGV4Lmg+DQoNCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXw0KTk9URVM6DQoxLglEb24ndCBmb3Jn
ZXQgdG8gY29weSBFREstZ2VuZXJhdGVkIHhwYXJhbWV0ZXJzLmggdG8gLi4v
YXJjaC9wcGMvcGxhdGZvcm1zLzR4eC94cGFyYW1ldGVycy94cGFyYW1ldGVy
c19tbDQwMy5oDQoNCg0KDQo9PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQ0KRmlsZXMgaW4gbGF0ZXN0IHBh
dGNoOg0KLi4vZHJpdmVycy9uZXQveGlsaW54X3RlbWFjID0NCk1ha2VmaWxl
DQphZGFwdGVyLmMNCnh0ZW1hYy5jDQp4dGVtYWNfY29udHJvbC5jDQp4dGVt
YWNfZmlmby5jDQp4dGVtYWNfaW50ci5jDQp4dGVtYWNfaW50cl9maWZvLmMN
Cnh0ZW1hY19pbnRyX3NnZG1hLmMNCnh0ZW1hY19sLmMNCnh0ZW1hY19zZ2Rt
YS5jDQp4dGVtYWMuaA0KeHRlbWFjX2kuaA0KeHRlbWFjX2wuaA0KDQpGaWxl
cyBpbiAuLlxsaW51eFxkcml2ZXJzXG5ldFx4aWxpbnhfdGVtYWMgPT4gICgq
KiA9IG5ldyBmaWxlcykNCg0KTWFrZWZpbGUNCmFkYXB0ZXIuYw0KeHRlbWFj
LmMNCnh0ZW1hY19jb250cm9sLmMNCnh0ZW1hY19maWZvLmMNCnh0ZW1hY19n
LmMqKg0KeHRlbWFjX2ludHIuYw0KeHRlbWFjX2ludHJfZmlmby5jDQp4dGVt
YWNfaW50cl9zZ2RtYS5jDQp4dGVtYWNfbC5jDQp4dGVtYWNfc2VsZnRlc3Qu
YyoqDQp4dGVtYWNfc2dkbWEuYw0KeHRlbWFjX3Npbml0LmMqKg0KeHRlbWFj
X3N0YXRzLmMqKg0KeHRlbWFjLmgNCnh0ZW1hY19pLmgNCnh0ZW1hY19sLmgN
Cg0KPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09DQpGaWxlcyBpbiAuLi9kcml2ZXJzL3hpbGlu
eF9lZGsgPT4NCg0KS2NvbmZpZw0KTWFrZWZpbGUNCnhiYXNpY190eXBlcy5j
DQp4ZG1hdjIuYw0KeGRtYXYyX2ludHIuYw0KeGRtYXYyX3NnLmMNCnhkbWF2
Ml9zaW1wbGUuYw0KeGlsaW54X3N5bXMuYw0KeHBhY2tldF9maWZvX2xfdjJf
MDBfYS5jDQp4cGFja2V0X2ZpZm9fdjJfMDBfYS5jDQp4YmFzaWNfdHlwZXMu
aA0KeGRtYWJkdjIuaA0KeGRtYXYyLmgNCnhkbWF2Ml9sLmgNCnhpby5oDQp4
cGFja2V0X2ZpZm9fbF92Ml8wMF9hLmgNCnhwYWNrZXRfZmlmb192Ml8wMF9h
LmgNCnhzdGF0dXMuaA0KDQpGaWxlcyBpbiAuLlxsaW51eFxhcmNoXHBwY1xw
bGF0Zm9ybXNceGlsaW54X29jcD0+DQpNYWtlZmlsZQ0KeGJhc2ljX3R5cGVz
LmMNCnh1dGlsX21lbXRlc3QuYw0KeHBhY2tldF9maWZvX3YyXzAwX2EuYw0K
eGRtYXYzLmMNCnhwYWNrZXRfZmlmb19sX3YyXzAwX2EuYw0KeGRtYXYzX2lu
dHIuYw0KeGlwaWZfdjFfMjNfYi5jDQp4ZG1hdjNfc2VsZnRlc3QuYw0KeGRt
YXYzX3NnLmMNCnhkbWF2M19zaW1wbGUuYw0KeHZlcnNpb24uYw0KeGVudi5o
DQp4ZW52X25vbmUuaA0KeGVudl92eHdvcmtzLmgNCnhkbWF2M19sLmgNCnhp
cGlmX3YxXzIzX2IuaA0KeGRtYXYzLmgNCnhwYWNrZXRfZmlmb19sX3YyXzAw
X2EuaA0KeGRtYWJkdjMuaA0KeHBhY2tldF9maWZvX3YyXzAwX2EuaA0KeHBh
cmFtZXRlcnNfbWwzMDAuaA0KeHN0YXR1cy5oDQp4dXRpbC5oDQp4YmFzaWNf
dHlwZXMuaA0KeGVudl9saW51eC5oDQp4dmVyc2lvbi5oDQo=

--0-1958789053-1162506041=:14180--
