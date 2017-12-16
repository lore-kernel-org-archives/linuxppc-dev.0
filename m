Return-Path: <rob@landley.net>
Received: from mail-vk0-x230.google.com (mail-vk0-x230.google.com
 [IPv6:2607:f8b0:400c:c05::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yzgY44FRrzDsQb
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 17 Dec 2017 08:34:15 +1100 (AEDT)
Received: by mail-vk0-x230.google.com with SMTP id o16so7548512vke.12
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Dec 2017 13:34:15 -0800 (PST)
MIME-Version: 1.0
From: Rob Landley <rob@landley.net>
Date: Sat, 16 Dec 2017 15:34:12 -0600
Message-ID: <CAOS_Y6SsUJYjrwc5GM-MpLWudWNVgkESKi4evNPs_JppEdQ8TQ@mail.gmail.com>
Subject: powerpc64 kernel panic if you disable CONFIG_PPC_TRANSACTIONAL_MEM?
To: Kernel Mailing List <linux-kernel@vger.kernel.org>,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Content-Type: multipart/mixed; boundary="94eb2c05fda6d889cb05607be012"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--94eb2c05fda6d889cb05607be012
Content-Type: text/plain; charset="UTF-8"

I just added a ppc64 target to https://github.com/landley/mkroot which
means I built 4.14 with the attached miniconfig and ran it with the
attached qemu command line, and it works fine as is but if you remove
the transactional mem line from the config the kernel panics instead
of launching a shell prompt:

init[1]: unhandled signal 4 at 0000000010001a04 nip 0000000010001a04
lr 000000001002ebe8 code 1
Kernel panic - not syncing: Attempted to kill init! exitcode=0x00000004

CPU: 0 PID: 1 Comm: init Not tainted 4.14.0 #1
Call Trace:
[c00000000e02fa40] [c0000000004ba730] dump_stack+0xb0/0xf0 (unreliable)
[c00000000e02fa80] [c0000000000602a0] panic+0x138/0x2f8
[c00000000e02fb20] [c00000000006541c] do_exit+0xa9c/0xaa0
[c00000000e02fbe0] [c0000000000654d8] do_group_exit+0x58/0xf0
[c00000000e02fc20] [c000000000073274] get_signal+0x1c4/0x6b0
[c00000000e02fd10] [c0000000000142a0] do_signal+0x60/0x290
[c00000000e02fe00] [c00000000001461c] do_notify_resume+0x8c/0xd0
[c00000000e02fe30] [c00000000000b630] ret_from_except_lite+0x5c/0x60
Rebooting in 1 seconds..

Rob

--94eb2c05fda6d889cb05607be012
Content-Type: application/octet-stream; name="powerpc64le.miniconf"
Content-Disposition: attachment; filename="powerpc64le.miniconf"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jb9u89te0

IyBtYWtlIEFSQ0g9cG93ZXJwYyBhbGxub2NvbmZpZyBLQ09ORklHX0FMTENPTkZJRz1wb3dlcnBj
NjRsZS5taW5pY29uZgojIG1ha2UgQVJDSD1wb3dlcnBjIC1qICQobnByb2MpCiMgYm9vdCB2bWxp
bnV4CgpDT05GSUdfUFBDNjQ9eQpDT05GSUdfUFBDX1BTRVJJRVM9eQpDT05GSUdfQ1BVX0xJVFRM
RV9FTkRJQU49eQpDT05GSUdfUFBDX09GX0JPT1RfVFJBTVBPTElORT15CgpDT05GSUdfQkxLX0RF
Vl9TRD15CkNPTkZJR19TQ1NJX0xPV0xFVkVMPXkKQ09ORklHX1NDU0lfSUJNVlNDU0k9eQpDT05G
SUdfQVRBPXkKCkNPTkZJR19ORVRfVkVORE9SX0lCTT15CkNPTkZJR19JQk1WRVRIPXkKQ09ORklH
X0hWQ19DT05TT0xFPXkKCiMgTm9uZSBvZiB0aGlzIHNob3VsZCBiZSBuZWNlc3NhcnkKQ09ORklH
X1BQQ19UUkFOU0FDVElPTkFMX01FTT15CkNPTkZJR19QUENfRElTQUJMRV9XRVJST1I9eQpDT05G
SUdfU0VDVElPTl9NSVNNQVRDSF9XQVJOX09OTFk9eQoKCiMgQ09ORklHX0VNQkVEREVEIGlzIG5v
dCBzZXQKQ09ORklHX0VBUkxZX1BSSU5USz15CkNPTkZJR19CSU5GTVRfRUxGPXkKQ09ORklHX0JJ
TkZNVF9TQ1JJUFQ9eQpDT05GSUdfTk9fSFo9eQpDT05GSUdfSElHSF9SRVNfVElNRVJTPXkKCkNP
TkZJR19CTEtfREVWPXkKQ09ORklHX0JMS19ERVZfSU5JVFJEPXkKQ09ORklHX1JEX0daSVA9eQoK
Q09ORklHX0JMS19ERVZfTE9PUD15CkNPTkZJR19FWFQ0X0ZTPXkKQ09ORklHX0VYVDRfVVNFX0ZP
Ul9FWFQyPXkKQ09ORklHX1ZGQVRfRlM9eQpDT05GSUdfRkFUX0RFRkFVTFRfVVRGOD15CkNPTkZJ
R19NSVNDX0ZJTEVTWVNURU1TPXkKQ09ORklHX1NRVUFTSEZTPXkKQ09ORklHX1NRVUFTSEZTX1hB
VFRSPXkKQ09ORklHX1NRVUFTSEZTX1pMSUI9eQpDT05GSUdfREVWVE1QRlM9eQpDT05GSUdfREVW
VE1QRlNfTU9VTlQ9eQpDT05GSUdfVE1QRlM9eQpDT05GSUdfVE1QRlNfUE9TSVhfQUNMPXkKCkNP
TkZJR19ORVQ9eQpDT05GSUdfUEFDS0VUPXkKQ09ORklHX1VOSVg9eQpDT05GSUdfSU5FVD15CkNP
TkZJR19JUFY2PXkKQ09ORklHX05FVERFVklDRVM9eQojQ09ORklHX05FVF9DT1JFPXkKI0NPTkZJ
R19ORVRDT05TT0xFPXkKQ09ORklHX0VUSEVSTkVUPXkKCg==
--94eb2c05fda6d889cb05607be012
Content-Type: application/x-sh; name="qemu-powerpc64le.sh"
Content-Disposition: attachment; filename="qemu-powerpc64le.sh"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_jb9u9v151

cWVtdS1zeXN0ZW0tcHBjNjQgLU0gcHNlcmllcyAtdmdhIG5vbmUgLW5vZ3JhcGhpYyAtbm8tcmVi
b290IC1tIDI1NiAtYXBwZW5kICJwYW5pYz0xIEhPU1Q9cG93ZXJwYzY0bGUgY29uc29sZT0vZGV2
L2h2YzAiIC1rZXJuZWwgdm1saW51eCAtaW5pdHJkIHBvd2VycGM2NGxlLWxpbnV4LW11c2wtcm9v
dC5jcGlvLmd6ICIkQCIK
--94eb2c05fda6d889cb05607be012--
