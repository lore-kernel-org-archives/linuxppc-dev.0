Return-Path: <chzigotzky@xenosoft.de>
Received: from mo6-p00-ob.smtp.rzone.de (mo6-p00-ob.smtp.rzone.de
 [IPv6:2a01:238:20a:202:5300::3])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yfV3t6y6vzDr8l
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Nov 2017 09:27:51 +1100 (AEDT)
Received: from [192.168.1.134] (ppp-188-174-64-161.dynamic.mnet-online.de
 [188.174.64.161]) by smtp.strato.de (RZmta 42.9 DYNA|AUTH)
 with ESMTPSA id m08e38tAIMRiNqp
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (curve secp521r1 with
 521 ECDH bits, eq. 15360 bits RSA))
 (Client did not present a certificate)
 for <linuxppc-dev@lists.ozlabs.org>;
 Sat, 18 Nov 2017 23:27:44 +0100 (CET)
To: linuxppc-dev@lists.ozlabs.org
From: Christian Zigotzky <chzigotzky@xenosoft.de>
Subject: Qoriq P5020 PowerPC board doesn't boot with the latest git version
 anymore
Message-ID: <ce2c842f-df48-6763-4626-adead5606acc@xenosoft.de>
Date: Sat, 18 Nov 2017 23:27:43 +0100
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="------------32E90AAADEA893ECF77833F0"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.
--------------32E90AAADEA893ECF77833F0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi All,

I tested the latest Git kernel version on my Varisys Cyrus Plus board 
(A-EON AmigaOne X5000) [1][2] with a Qoriq P5020 PowerPC CPU from NXP 
today. Unfortunately it doesn't boot anymore.

My Varisys Nemo board (A-EON AmigaOne X1000) [3], boots without any 
problems.

I bisected between the final kernel 4.14.0 and the git version from Mon 
Nov 13 21:14:07 2017 -0800.

a8a217c22116eff6c120d753c9934089fb229af0 is the first bad commit. [4]

Please find attached the git bisect log.

I tried to revert the bad commit I have found with bisect but 
unfortunately it doesn't work because of some conflicts.

git revert a8a217c22116eff6c120d753c9934089fb229af0

error: could not revert a8a217c... locking/core: Remove 
{read,spin,write}_can_lock()
hint: after resolving the conflicts, mark the corrected paths
hint: with 'git add <paths>' or 'git rm <paths>'
hint: and commit the result with 'git commit'

I tried to revert the bad commit in the git version from Mon Nov 13 
21:14:07 2017 -0800 but unfortunately it doesn't work either.

error: could not revert a8a217c... locking/core: Remove 
{read,spin,write}_can_lock()
hint: after resolving the conflicts, mark the corrected paths
hint: with 'git add <paths>' or 'git rm <paths>'
hint: and commit the result with 'git commit'

Could you please help me to find the bug?

Thanks,
Christian


[1] http://www.amigaos.net/hardware/133/amigaone-x5000
[2] http://wiki.amiga.org/index.php?title=AmigaONE_X5000
[3] https://en.wikipedia.org/wiki/AmigaOne_X1000
[4] 
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=a8a217c22116eff6c120d753c9934089fb229af0


--------------32E90AAADEA893ECF77833F0
Content-Type: text/plain; charset=UTF-8;
 name="bisect-4.15"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="bisect-4.15"

Z2l0IGxvZwoKZ2l0IGJpc2VjdCBzdGFydAoKZ2l0IGJpc2VjdCBnb29kIGJlYmM2MDgyZGEw
YTlmNWQ0N2ExZWEyZWRjMDk5YmY2NzEwNThiZDQgKExpbnV4IDQuMTQuMCBmaW5hbCkKCmdp
dCBiaXNlY3QgYmFkIDg5NDAyNWYyNGJkMDI4OTQyZGEzZTYwMmI4N2Q5ZjcyMjMxMDliMTQg
KExpbnV4IDQuMTUgYWxwaGExIE1vbiBOb3YgMTMgMjE6MTQ6MDcgMjAxNyAtMDgwMCkKCk91
dHB1dDoKCkJpc2VjdGluZzogMTEyOCByZXZpc2lvbnMgbGVmdCB0byB0ZXN0IGFmdGVyIHRo
aXMgKHJvdWdobHkgMTAgc3RlcHMpCls3ZDU4ZTFjOTA1OWVlZmUwMDY2YzVhY2YyZmZhNTgy
ZjZmMDE4MGUzXSBNZXJnZSBicmFuY2ggJ3NtcC1ob3RwbHVnLWZvci1saW51cycgb2YgZ2l0
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RpcC90aXAKCmdp
dCBiaXNlY3QgYmFkCgpPdXRwdXQ6CgpCaXNlY3Rpbmc6IDU1OSByZXZpc2lvbnMgbGVmdCB0
byB0ZXN0IGFmdGVyIHRoaXMgKHJvdWdobHkgOSBzdGVwcykKWzhlOWEyZGJhODY4NjE4N2Q4
YzgxNzllNWI4NjY0MGU2NTM5NjM4ODldIE1lcmdlIGJyYW5jaCAnbG9ja2luZy1jb3JlLWZv
ci1saW51cycgb2YgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwv
Z2l0L3RpcC90aXAKCmdpdCBiaXNlY3QgYmFkCgpPdXRwdXQ6CgpCaXNlY3Rpbmc6IDI3MiBy
ZXZpc2lvbnMgbGVmdCB0byB0ZXN0IGFmdGVyIHRoaXMgKHJvdWdobHkgOCBzdGVwcykKW2Rl
ZTAyNzcwY2RjZDhiYzA2YTQ4YzkxN2NlNWRmMmZiNTZjZjYwNTldIE1lcmdlIHRhZyAnbW1j
LXY0LjE1JyBvZiBnaXQ6Ly9naXQua2VybmVsLm9yZy9wdWIvc2NtL2xpbnV4L2tlcm5lbC9n
aXQvdWxmaC9tbWMKCmdpdCBiaXNlY3QgZ29vZAoKT3V0cHV0OgoKQmlzZWN0aW5nOiAxMjkg
cmV2aXNpb25zIGxlZnQgdG8gdGVzdCBhZnRlciB0aGlzIChyb3VnaGx5IDcgc3RlcHMpCltk
NjBhNTQwYWM1ZjJmYmFiM2U2ZmU1OTI3MTdiNDQ1YmQ3MzQzYTkxXSBNZXJnZSBicmFuY2gg
J2Zvci1saW51cycgb2YgZ2l0Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L3MzOTAvbGludXgKCmdpdCBiaXNlY3QgZ29vZAoKT3V0cHV0OgoKQmlzZWN0aW5n
OiA2NCByZXZpc2lvbnMgbGVmdCB0byB0ZXN0IGFmdGVyIHRoaXMgKHJvdWdobHkgNiBzdGVw
cykKWzdhMTBlMmE5MTkwNjI4YTQwMjRlYTM5NGNlN2JkNjQxYWU0MGZmZDFdIHg4NjogVXNl
IGxvY2tkZXAgdG8gYXNzZXJ0IElSUXMgYXJlIGRpc2FibGVkL2VuYWJsZWQKCmdpdCBiaXNl
Y3QgYmFkCgpPdXRwdXQ6CgpCaXNlY3Rpbmc6IDMyIHJldmlzaW9ucyBsZWZ0IHRvIHRlc3Qg
YWZ0ZXIgdGhpcyAocm91Z2hseSA1IHN0ZXBzKQpbZWVhZmNjNWE1OTI1ZDA4MTlkYWQ0NjJl
YWMxZDQyZmRhNWZiZTM2Zl0gbG9ja2luZy9hdG9taWNzLCBmaXJtd2FyZS9pdmM6IENvbnZl
cnQgQUNDRVNTX09OQ0UoKSB0byBSRUFEX09OQ0UoKS9XUklURV9PTkNFKCkKCmdpdCBiaXNl
Y3QgYmFkCgpPdXRwdXQ6CgpCaXNlY3Rpbmc6IDE1IHJldmlzaW9ucyBsZWZ0IHRvIHRlc3Qg
YWZ0ZXIgdGhpcyAocm91Z2hseSA0IHN0ZXBzKQpbYTRjMTg4N2Q0YzE0NjJiMGVjNWE4OTg5
ZjhiYTNjZGQ5MDU3YTI5OV0gbG9ja2luZy9hcmNoOiBSZW1vdmUgZHVtbXkgYXJjaF97cmVh
ZCxzcGluLHdyaXRlfV9sb2NrX2ZsYWdzKCkgaW1wbGVtZW50YXRpb25zCgpnaXQgYmlzZWN0
IGJhZAoKT3V0cHV0OgoKQmlzZWN0aW5nOiA3IHJldmlzaW9ucyBsZWZ0IHRvIHRlc3QgYWZ0
ZXIgdGhpcyAocm91Z2hseSAzIHN0ZXBzKQpbYzA5MDUxMTVhNTVjOGEzMDExZDdiN2U2ZWU1
ZDYzNjUzYzFlOTlmMV0gbG9ja2luZy9hcmNoLCBpYTY0OiBBZGQgX19kb3duX3JlYWRfa2ls
bGFibGUoKQoKZ2l0IGJpc2VjdCBnb29kCgpPdXRwdXQ6CgpCaXNlY3Rpbmc6IDMgcmV2aXNp
b25zIGxlZnQgdG8gdGVzdCBhZnRlciB0aGlzIChyb3VnaGx5IDIgc3RlcHMpClswZGMyMDhi
NWQ1ZmVlZGM3OTVjYmYxMjQ1MzlkZWNkMTgyYzhlOTllXSBsb2NraW5nL3J3c2VtLCBmczog
VXNlIGtpbGxhYmxlIGRvd25fcmVhZCgpIGluIGl0ZXJhdGVfZGlyKCkKCmdpdCBiaXNlY3Qg
Z29vZAoKT3V0cHV0OgoKQmlzZWN0aW5nOiAxIHJldmlzaW9uIGxlZnQgdG8gdGVzdCBhZnRl
ciB0aGlzIChyb3VnaGx5IDEgc3RlcCkKW2E4YTIxN2MyMjExNmVmZjZjMTIwZDc1M2M5OTM0
MDg5ZmIyMjlhZjBdIGxvY2tpbmcvY29yZTogUmVtb3ZlIHtyZWFkLHNwaW4sd3JpdGV9X2Nh
bl9sb2NrKCkKCmdpdCBiaXNlY3QgYmFkCgpPdXRwdXQ6CgpCaXNlY3Rpbmc6IDAgcmV2aXNp
b25zIGxlZnQgdG8gdGVzdCBhZnRlciB0aGlzIChyb3VnaGx5IDAgc3RlcHMpClsyNmM0ZWIx
OTJjNjIyNGU1Mjk3NDk2Y2VhZDM2NDA0YjYyZmIwNzFiXSBsb2NraW5nL3J3c2VtLCBzZWN1
cml0eS9hcHBhcm1vcjogUmVwbGFjZSBob21lYnJldyB1c2Ugb2Ygd3JpdGVfY2FuX2xvY2so
KSB3aXRoIGxvY2tkZXAKCmdpdCBiaXNlY3QgZ29vZAoKT3V0cHV0OgoKYThhMjE3YzIyMTE2
ZWZmNmMxMjBkNzUzYzk5MzQwODlmYjIyOWFmMCBpcyB0aGUgZmlyc3QgYmFkIGNvbW1pdApj
b21taXQgYThhMjE3YzIyMTE2ZWZmNmMxMjBkNzUzYzk5MzQwODlmYjIyOWFmMApBdXRob3I6
IFdpbGwgRGVhY29uIDx3aWxsLmRlYWNvbkBhcm0uY29tPgpEYXRlOiAgIFR1ZSBPY3QgMyAx
OToyNToyNyAyMDE3ICswMTAwCgogICAgbG9ja2luZy9jb3JlOiBSZW1vdmUge3JlYWQsc3Bp
bix3cml0ZX1fY2FuX2xvY2soKQogICAgCiAgICBPdXRzaWRlIG9mIHRoZSBsb2NraW5nIGNv
ZGUgaXRzZWxmLCB7cmVhZCxzcGluLHdyaXRlfV9jYW5fbG9jaygpIGhhdmUgbm8KICAgIHVz
ZXJzIGluIHRyZWUuIEFwcGFybW9yICh0aGUgbGFzdCByZW1haW5pbmcgdXNlciBvZiB3cml0
ZV9jYW5fbG9jaygpKSBnb3QKICAgIG1vdmVkIG92ZXIgdG8gbG9ja2RlcCBieSB0aGUgcHJl
dmlvdXMgcGF0Y2guCiAgICAKICAgIFRoaXMgcGF0Y2ggcmVtb3ZlcyB0aGUgdXNlIG9mIHty
ZWFkLHNwaW4sd3JpdGV9X2Nhbl9sb2NrKCkgZnJvbSB0aGUKICAgIEJVSUxEX0xPQ0tfT1BT
IG1hY3JvLCBkZWZlcnJpbmcgdG8gdGhlIHRyeWxvY2sgb3BlcmF0aW9uIGZvciB0ZXN0aW5n
IHRoZQogICAgbG9jayBzdGF0dXMsIGFuZCBzdWJzZXF1ZW50bHkgcmVtb3ZlcyB0aGUgdW51
c2VkIG1hY3JvcyBhbHRvZ2V0aGVyLiBUaGV5CiAgICBhcmVuJ3QgZ3VhcmFudGVlZCB0byB3
b3JrIGluIGEgY29uY3VycmVudCBlbnZpcm9ubWVudCBhbmQgY2FuIGdpdmUKICAgIGluY29y
cmVjdCByZXN1bHRzIGluIHRoZSBjYXNlIG9mIHFyd2xvY2suCiAgICAKICAgIFNpZ25lZC1v
ZmYtYnk6IFdpbGwgRGVhY29uIDx3aWxsLmRlYWNvbkBhcm0uY29tPgogICAgU2lnbmVkLW9m
Zi1ieTogUGV0ZXIgWmlqbHN0cmEgKEludGVsKSA8cGV0ZXJ6QGluZnJhZGVhZC5vcmc+CiAg
ICBDYzogTGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPgog
ICAgQ2M6IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFkZWFkLm9yZz4KICAgIENjOiBU
aG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4KICAgIENjOiBwYXVsbWNrQGxp
bnV4LnZuZXQuaWJtLmNvbQogICAgTGluazogaHR0cDovL2xrbWwua2VybmVsLm9yZy9yLzE1
MDcwNTUxMjktMTIzMDAtMi1naXQtc2VuZC1lbWFpbC13aWxsLmRlYWNvbkBhcm0uY29tCiAg
ICBTaWduZWQtb2ZmLWJ5OiBJbmdvIE1vbG5hciA8bWluZ29Aa2VybmVsLm9yZz4KCjowNDAw
MDAgMDQwMDAwIDViNDM1NDIyNjk4ZTRjYjEwYTY5YzhjNWQ2MzczNDc4NWI0ZTFmM2MgMzUw
OTM5MzdiYTQ4N2Q4YjVlY2Y3NzNjMzg0MzlmOTk4MDFmNDA0MSBNCWFyY2gKOjA0MDAwMCAw
NDAwMDAgYzNmYTJkMWZjNDEyMThlNDNhNzZlYjZkOTc4MDhkZTViZTNhMDM1NSA2ZDQ2ODJk
ZDE5M2Q3OWY4NjhiMjhlY2E5NzE0NzE2Y2UzZGJmN2M5IE0JaW5jbHVkZQo6MDQwMDAwIDA0
MDAwMCAyYWMyZmIxZTU4ZWRjZjNmNmY5MTJlY2Y2NjQzMWY4YjBlNjkxNGI5IGQ3Yjc4MTRi
N2IzNDllMmYwZmQ3NTc4YjM1NzI2MDM3Mjk0ZWE5YjQgTQlrZXJuZWwK
--------------32E90AAADEA893ECF77833F0--
