Message-ID: <3E1DE0E2.9030801@redswitch.com>
Date: Thu, 09 Jan 2003 12:51:46 -0800
From: "Xiaogeng (Shawn) Jin" <xjin@redswitch.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: embed_config undefined?
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm migrating the linux kernel on a custom 8xx board from 2.4.4 to
2.4.21 (from linuxppc_2_4_devel tree) and had such a problem at the last
step of compilation.

ppc_8xx-ld -T ../ld.script -Ttext 0x00180000 -Bstatic -o zvmlinux head.o
../comm
on/relocate.o  misc-embedded.o ../common/misc-common.o
../common/string.o ../com
mon/util.o embed_config.o m8xx_tty.o image.o ../lib/zlib.a
misc-embedded.o: In function `decompress_kernel':
misc-embedded.o(.text+0x28): undefined reference to `embed_config'
make[2]: *** [zvmlinux] Error 1

The boot code has been re-organized in the latest kernel compared to
2.4.4. I checked embed_config.c and found that some boards need the
embed_config() function. I'm not sure what kind of boards need such a
function. 2.4.4 has embed_config.c too but my board doesn't need it.
What's the difference? Basically embed_config() just set a bd_t struct.
But what values need to be set for a specific board? Can anyone give an
explanation? Thank you very much.

--
Shawn Jin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
