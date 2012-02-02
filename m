Return-Path: <acrux_it@libero.it>
Received: from outrelay08.libero.it (outrelay08.libero.it [212.52.84.112])
 by ozlabs.org (Postfix) with ESMTP id E9F121007D1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Feb 2012 13:52:55 +1100 (EST)
Date: Thu, 2 Feb 2012 03:48:03 +0100
From: acrux <acrux_it@libero.it>
To: linuxppc-dev@lists.ozlabs.org
Subject: Efika (mpc5200b): sound doesn't build/work from linux-2.6.38.x
Message-Id: <20120202034803.2fb7690b.acrux_it@libero.it>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Thu__2_Feb_2012_03_48_03_+0100_gBp2LG_uT1qrxx.Y"
Cc: Jon Smirl <jonsmirl@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

--Multipart=_Thu__2_Feb_2012_03_48_03_+0100_gBp2LG_uT1qrxx.Y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

board: Genesi Efika (MPC5200B)
problem: unable to use sound subsystem instead it works fine with linux-2.6.36.4 (+ device tree supplement, attached) .

With linux-2.6.38.8 and linux-2.6.39.4 it doesn't build.
That's from my build log:

[...]
  LD      sound/soc/blackfin/built-in.o
  LD      sound/soc/codecs/built-in.o
  CC [M]  sound/soc/codecs/stac9766.o
  LD [M]  sound/soc/codecs/snd-soc-stac9766.o
  LD      sound/soc/davinci/built-in.o
  LD      sound/soc/ep93xx/built-in.o
  LD      sound/soc/fsl/built-in.o
  CC [M]  sound/soc/fsl/mpc5200_dma.o
sound/soc/fsl/mpc5200_dma.c:372:16: warning: 'struct of_device' declared inside parameter list
sound/soc/fsl/mpc5200_dma.c:372:16: warning: its scope is only this definition or declaration, which is probably not what you want
sound/soc/fsl/mpc5200_dma.c: In function 'mpc5200_hpcd_probe':
sound/soc/fsl/mpc5200_dma.c:383:31: error: dereferencing pointer to incomplete type
sound/soc/fsl/mpc5200_dma.c:384:31: error: dereferencing pointer to incomplete type
sound/soc/fsl/mpc5200_dma.c:385:14: error: dereferencing pointer to incomplete type
sound/soc/fsl/mpc5200_dma.c:390:14: error: dereferencing pointer to incomplete type
sound/soc/fsl/mpc5200_dma.c:402:27: error: dereferencing pointer to incomplete type
sound/soc/fsl/mpc5200_dma.c:414:20: error: dereferencing pointer to incomplete type
sound/soc/fsl/mpc5200_dma.c:428:14: error: dereferencing pointer to incomplete type
sound/soc/fsl/mpc5200_dma.c:475:21: error: dereferencing pointer to incomplete type
sound/soc/fsl/mpc5200_dma.c:478:38: error: dereferencing pointer to incomplete type
sound/soc/fsl/mpc5200_dma.c: At top level:
sound/soc/fsl/mpc5200_dma.c:490:39: warning: 'struct of_device' declared inside parameter list
sound/soc/fsl/mpc5200_dma.c: In function 'mpc5200_hpcd_remove':
sound/soc/fsl/mpc5200_dma.c:492:47: error: dereferencing pointer to incomplete type
sound/soc/fsl/mpc5200_dma.c:494:2: error: dereferencing pointer to incomplete type
sound/soc/fsl/mpc5200_dma.c:496:33: error: dereferencing pointer to incomplete type
sound/soc/fsl/mpc5200_dma.c:508:21: error: dereferencing pointer to incomplete type
sound/soc/fsl/mpc5200_dma.c: At top level:
sound/soc/fsl/mpc5200_dma.c:522:2: error: unknown field 'owner' specified in initializer
sound/soc/fsl/mpc5200_dma.c:522:2: warning: initialization from incompatible pointer type
sound/soc/fsl/mpc5200_dma.c:523:2: error: unknown field 'name' specified in initializer
sound/soc/fsl/mpc5200_dma.c:523:2: warning: initialization from incompatible pointer type
sound/soc/fsl/mpc5200_dma.c:524:2: error: unknown field 'match_table' specified in initializer
sound/soc/fsl/mpc5200_dma.c:524:2: warning: initialization from incompatible pointer type
sound/soc/fsl/mpc5200_dma.c:525:2: warning: initialization from incompatible pointer type
sound/soc/fsl/mpc5200_dma.c:526:2: warning: initialization from incompatible pointer type
make[3]: *** [sound/soc/fsl/mpc5200_dma.o] Error 1
make[2]: *** [sound/soc/fsl] Error 2
make[1]: *** [sound/soc] Error 2
make: *** [sound] Error 2


With linux-3.0.18, linux-3.1.10 and linux-3.2.2 it builds but doesn't work.
That's from my dmesg:

[...]
asoc: error - multiple DAI f0002200.sound registered with no name
mpc5200-psc-ac97 f0002200.sound: Failed to register DAI
mpc5200-psc-ac97: probe of f0002200.sound failed with error -22


best,
--nico
-- 
acrux <acrux@cruxppc.org>

--Multipart=_Thu__2_Feb_2012_03_48_03_+0100_gBp2LG_uT1qrxx.Y
Content-Type: application/octet-stream;
 name="efika.forth.gz"
Content-Disposition: attachment;
 filename="efika.forth.gz"
Content-Transfer-Encoding: base64

H4sICL74KU8CAGVmaWthLmZvcnRoAL1a6W7bMAz+P2DvwB3ArjhzuvvEuiw7gB1d213AgEG2lUSL
bBmW3CR7+pFy4iO24y7rFqBtLJEURX6kSLnf4eWHw+PX58+dP9e/CKOxmDG4s+e6z+EFPxE+h+OE
czhK41jykEcGcO7eYDC4fRH8xPJc9a/ZQXjFI64FfDra78GbyO/nFFNj4oc3b87n836s5jwJ+AmX
KuZJXyWTmzBWCWhcQCWGWIgLtfkOU84CnkiuNT3ri3ATeaI4UeFFGIsocAKr4flzkH2CS7lywCNf
BdwRqDAyZoSOwa04JzzRQkUXIU5IBbM8f241zaNgvZCXCmlEdJMZ1rwWEoWxT4ZyiGa9njaJiCYN
VF4D2erpRpncV2HMjPAkP52CWqVRUFdR45CWvbWKsfYd5j+4V9OzRuoVtO3KtitqZ93FXsn+DUOF
LDt1q2WKlsEhniRpbHRtme+wnwZCgdCgIjg4Gu714GeqDeEJ+fB3yAx6mkmI0yRWmmvLN9gAh8+l
xO8BX9SWiPi86niiJ17/mXsR9oI0XkMrYiHPYbaMc3p3MbA/CUdrl4RYvzXDpgDsD5JUU2plmMD0
tCFH3b3bLofmHUZmanVnB/QACFxCT3NDVMH4HT6mwp+B4dqAUaA5BzGG/eGDe+QZHjEUiJTuYuzi
x3NdILPRj3xGuHCBRTT/BNnySKBURJykKYmivJBPlnlVMaznDMcvnD/HpeYFMe7k/Dkz5VGm7dHh
/rvSVvVGOCUs7Ax4S9Qd8ZZu55AvU1hBZXQh9s1UaDIwQ36MkQiRnlIgNDjo4M2wfcex8Ds3TDTd
+yWys8lw5CaeCCbLavdhX2qFqi5KEUvYATo4nCgNPZ4A04ASwcNZXH/Tu1Zo53YpA6YsMafYc412
dz/ne6btgNCU0QZbclkP3oooXYCbWYJrECYX5p4qxxUri8jnOaQwWCBkIuoBk3O2tAMJ7yEjH2My
5gHoQtN+v23Rsl+2uXpE4iNu2jHKVxSdnhvz0wAVyc4OqM+5NkMVhmXte8WxBSHXG7vxkAOJu/NM
Tti9pS7anfAYshmHwd1iMzkZDgEDjxl/2ocvHKbshFPyD5QFz1gk2lAuAq+MsikFqxZhLJfgcZ+l
moMaWw6E2VpFmKtkpvtrTWoVAj6WgdZSP9Q2jIewCwPUEEcqnzYBomGwhTYXKZWKKyaM1BzmHHwW
gTYq4XazAQsj/JK7p17ptMPtPZ9jgf18neDAAR/NOuFo7dyYWchpoKi1XhGaDmEQWWmkZMATmFFE
SU0ymS6dJgFH5KS+ESc8E43QHKDh6Hiu4jjVXiuEcc5RU1+UT60KwQZOacgTE9qnYJXavAHtVnJ3
UDi5Et2xTmQYQ2eSFYpa45Uir2YxkShlIEJp9siaCSnRXWN8WEJoT++I3Dd8fXiQWbnVtJxatBa7
Vhq4BhMPP7wYvRq973mKJUGhf4sAOKBm7WAIR0tteLhFHoLGT0RMu2iW6sWSRT2r+oaYP8+4L8WC
LJoDsWwKAnh2Llaw2mpMrfyKKeur7b948eb9K3g/+gKj98eHb0ZHcPwBjl+P4MXo85vhCI4PRyMk
JNqhVFgJvxC0My+1Pn2nglRycCDiPMjCzKh1zHosDSBhhmvgxu9bZJg0iQgZJM8nedruyfbNELKI
TWwb3odPmo9TCVIYI3mWTvrwHlfRKAeQJFnSUrRxMpcN9CBIuNYwF2aqUgOTFJ/IlVfRij7TnAiX
a+2EQfRaS98Z7H29hubYtkXb6O8HlJTaibIyfptr6h0XIFMQdnRbBe27g+GdvcWiXYcN/CFLfzt8
V50LRgSl//vVVg6KdENaVmXXibyCqvuMbj+iqx1ZlmsO3nyAq0d0uvJrDT7JZizZ3zgDiSexUKd0
h879UV6/lkhO6wLPuuC2Sy5oPhmsbt3lkqXbOdlXagr72ax8SbwTMj1rYyvRl4bvNQ/fahiu1Tld
lUQ7Zr5gmZfGTZjJZs4KM858lsZ/DpxCid2B41vg7N1vB06hYDd6Ool3gtKtM4XS/S1lakcVS0J3
5q5P745PguhrMZmi17SSWQ6/SpfMCZNwYNvgrJo6kshyDY5FyBOdMVJXIiYRldyaZsHQJLigbauL
kDHCZ7LQxXYnklAlonUF8Z1KYj9N6GpFLiEU9rSsZFWSnS0Mg12DQ0uzQz4tr7zrmXZv4JK3tyRU
0q07Iojs7GKhgr7a3UW9Tz2e8pIfpdCGB1nzIzRxeMxD780TFU26A8f9P9gmAAGTEsyUDsVjDVmf
UH5VQWQPMQEYhyHxVftNBOA4cI2mAh6bKX0ZwFPbnN0HlzpwUbkovQePKzerUMw1dMIPoNgNlO5V
m8kJOdeL4Sq27rruVmG1qSKqNmPcotyCmiKsztkWcDXCIv6apUzi7kis76ceQsWn+xquzFQL8xZT
fL1Y47Fa30AsONXx7zDhhpBFZX3CfIPsKEmsO06a+dp0J+KCQHl2f/6FQlp2jcG0L0Qh0QoizVZ3
DzV5pz63C86mM7o1yUDjKd15K2s/tXdgO3Dusmh3IoTGZFV3PcTCn21LTHC6/AVdeaxGWUls+Wx2
A5Jdhn23T/T3UZH45nRzGKgJhCyZIWqMohzoVu+X0JTP1pmkHNZd90hTpp15YAq9O+jJf3We+luU
199sJ76+jO7jucOimU3cL1TII4zRyOcJEdlGv18qFPJLbhKzQ51Qf2t5adXMO5RTdNMRv8mgxS/e
Sk2BE3T1dW2X6U48XdYNW0d3vQK55a5aukr+rL9DLobv/IvzOacoDN8QFLnrab9dlqqH8IZDaMNb
YytcOprLMZRyL12zqzSB2BarnKBH74BnNV6RETxdEeJ8Y7xuPP7JW5diL5vnDRrnil6pWIYMTTjZ
aHOcFUX/6HAEz/GG7XD/1Yf3R6s3gvj0DoYqMomSkidwla7UeEBG4ORVtD+PQUv8XblJA+LLrtKu
lUKyJnDn8j2g17MlJFTjhIcqWTp+sUwVJ5sl+cBtKcmLyt/q/c7KLau/wyFbKeGDU73WrtF13510
VMJf3z6H/cQThnwai5hLEfH8LRlok47H6/8jsGV92YsF9+4OXEivHs1bvTQYr7zU7qZCsb91jUP6
dfdgRHZmbiED5/+Lhd89pQwMDz99hYODIU1krvtg9WdSLiGNyFsYiBR7Gf0SU1XRSvMFriWIgkkY
c2bSrEGTwmOG9fHU9PmTxyHq+xSu0g010Pcn4TwImduzfwbZn71easfSMMChlEaoIbJnf/BwACeh
xEV/2VcuT27inm7qgN0CDEGtJH9izBJfrWNJcZm0RLhsZzsRAVdPEoa/o7H38L7rLu6iU+4/u1uI
+A29G46ORScAAA==

--Multipart=_Thu__2_Feb_2012_03_48_03_+0100_gBp2LG_uT1qrxx.Y--
