Return-Path: <matt.hevern@nec.com.au>
Message-ID: <45188E24.1090009@nec.com.au>
Date: Tue, 26 Sep 2006 12:19:16 +1000
From: Matt Hevern <matt.hevern@nec.com.au>
MIME-Version: 1.0
To: Linuxppc-embedded@ozlabs.org
Subject: fs_enet - support for SCC on CPM2?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I am trying to compile for an freescale 82xx (CPM2) series processor, 
with ethernet on an SCC. (kernel 2.6.x)
 From what i can see, in the file drivers/net/fs_enet/fs_enet-main.c, 
the config option "CONFIG_FS_ENET_HAS_SCC"  pulls in "fs_scc_ops" which 
are defined in
drivers/net/fs_enet/mac-scc.c, but this file  does not seem to have 
support for 82xx series, failing with various compile errors:
------errors
drivers/net/fs_enet/mac-scc.c: In function `scc_cr_cmd':
drivers/net/fs_enet/mac-scc.c:94: error: `cpm8xx_t' undeclared (first 
use in this function)
drivers/net/fs_enet/mac-scc.c:94: error: (Each undeclared identifier is 
reported only once
drivers/net/fs_enet/mac-scc.c:94: error: for each function it appears in.)
drivers/net/fs_enet/mac-scc.c:94: error: `immap_t' undeclared (first use 
in this function)
...etc
------end-errors

It seems like these errors are mostly due to the driver being tailored 
for 8xx series.

Are there any patches/fixes for "fs_enet" for ethernet on SCC for 82xx 
series?  - or other options?

Thanks in advance.

Matt
