Message-ID: <3C23BC8B.83D8F4DB@mvista.com>
Date: Fri, 21 Dec 2001 14:49:47 -0800
From: Frank Rowand <frank_rowand@mvista.com>
Reply-To: frowand@mvista.com
MIME-Version: 1.0
To: trini@mvista.com, linuxppc-dev@lists.linuxppc.org
Cc: frowand@mvista.com
Subject: patch - KGDB read and write of IO registers
Content-Type: multipart/mixed;
 boundary="------------835AF1784E46B25E805F457D"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------835AF1784E46B25E805F457D
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Tom,

Please apply the attached patch to linuxppc_2_4_devel.

The patch allows IO device registers to be accessed by KGDB via word
(or halfword) loads and stores for word (or halfword) sized objects
when naturally aligned.  The previous behaviour was to always do
byte load and stores which can result in side effects when accessing
an IO device register.

A second fix in the patch is to pass the correct address to
flush_icache_range() when writing to memory in hex2mem().

Thanks!

-Frank
--
Frank Rowand <frank_rowand@mvista.com>
MontaVista Software, Inc
--------------835AF1784E46B25E805F457D
Content-Type: application/x-gzip;
 name="patch_getput_iospace.gz"
Content-Transfer-Encoding: base64
Content-Disposition: inline;
 filename="patch_getput_iospace.gz"

H4sICH+JIjwAA3BhdGNoX2dldHB1dF9pb3NwYWNlAM1W33PaRhB+Fn/FPnkEAoOETB1jPE6T
aSZP8aR563SYk3SgSw6J3p1sZxr/7929AxshzI+20ykvkna/Xe1+q/2OXq8HUhTV4/mnzx8/
9JlK8/5ymfa/cVVwSbc9barkPPW+5BW85ylEAwhHV1F0NXyD94OwFQSBS3F89HB4NYxc9O0t
9MI3YTe8gICu8Qhub1ugDTMiharQYl7wDNKcKei0YMEXUc4fffeMT92VK6lmXRCFgbSsCtNu
wZ+tnlcPT/NxK9iybRt1XioDZrGc6ppdlsUcrF2OW9ACT8zA/zbPkqnm5uti6fuE6LRnrJJm
ioYpFtSGyQQGbSwFPC/jSTWfczV1kJwVmeQKJmCz1IxjLN17yIXk4Nt2cEg3LhE6vDTHKOo9
CCzSo+ZxCBNAZqgr/RtCbm4g/n2P/wwGjzMEBNim1+/A2zTlWgtsMxxBIgxgLYBTotsy+cpT
o5FfYEAYySmq00FeWIZmbVSVGlEWIDQo/kclFJJmSmD3pcggQZAW2TqIz2Y23axUoMsFh4+f
MGgutOFKn1tQ39VFLDsKiMqoDWdnaLBct5EAbCJckUzkYIBnR0f8+Fsz7VDA2GIoMsB07qnJ
ju+SIIMhvXJN1AEsXJ6AjQ9hHbQ2pCfgUnOocxLv4GS4gxNZ54Q2pclIvLdySZVHx3XpsAe7
3MAOjseGoxOwx01QnjBBefwE5c4JuqnsXnDy1DfcWvat+OuAzQKfSISesA54KQPs5nOlcBHT
ssiEXWFcPsRYZY7CuBv+BEEUX3QvLjeVeS3I+LoIC/U3VHhDm7cFmZ7F+BRlpoiNnyCb8z//
OqUS8+nqWz5NyWkq62jkzub4T9SdpM8Xk8EYxLUlCG+CoKbwdMy5qbbh+pp2c+X6UfOtJN5+
LBhlWftHkq5Nqfj/UNOblIQrBXf+Hw0/XB7wx6/7Vyx6u88RrOX5y6qdJ/+CTjf7jDb6kDv6
iOID/sF+fzg64I/2++FAfbCnvh082w3dpFk2DqmGmL6+Ty+C2lyota9RktdYqRcFpe2Vlc6n
ImVpzqeKFXPu+yhUbat567vACZ+t1i3kalV+oWgwOYeMGQY2C0nlPZMCLdy6NvfPIp536PXX
r5VsVcOzsAVOg6GHmzU+8QSIh1EXD4CLQYwX0n9PcVOpAkJUSmSk1cP4d2Vxz0ltsfBf795+
fgeo0NkDQx0xii3BfF9yTJ9xKx/4r148Ag2bSSiqRcLVOb0y2Mr0d3IAsownAnzJUbQMSyTF
FIYhnTbngi2XJIgJNw+cF3BXPnB1t6te3SW5tMnca9CARzZ+LQRbKrFgSsjvaGMGPrz/GSvK
UOoMBqHe/QWRMhzmWA0AAA==
--------------835AF1784E46B25E805F457D--


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
