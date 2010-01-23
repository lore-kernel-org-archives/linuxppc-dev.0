Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 215CAB7CB9
	for <linuxppc-dev@ozlabs.org>; Sun, 24 Jan 2010 05:52:36 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: Re: [net-next-2.6 PATCH 2/3] fs_enet: Add support for MPC512x to
	fs_enet driver
Date: Sat, 23 Jan 2010 10:23:14 +0100
References: <1264039999-25731-1-git-send-email-agust@denx.de>
	<20100121.012235.161201297.davem@davemloft.net>
	<4B5871F2.9090005@grandegger.com>
In-Reply-To: <4B5871F2.9090005@grandegger.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201001231023.14372.arnd@arndb.de>
Cc: wd@denx.de, dzu@denx.de, netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	agust@denx.de, David Miller <davem@davemloft.net>, kosmo@semihalf.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thursday 21 January 2010, Wolfgang Grandegger wrote:
> The major problem that Anatolij tries to solve are the different
> register layouts of the supported SOCs, MPC52xx and MPC8xx. They use the
> same registers but at different offsets. Therefore we cannot handle
> this with a single "fec_t" struct to allow building a single kernel
> image. Instead it's handled by filling a table with register addresses:
> 
>         if (of_device_is_compatible(ofdev->node, "fsl,mpc5121-fec")) {
>                 fep->fec.fec_id = FS_ENET_MPC5121_FEC;
>                 fec_reg_mpc5121(ievent);
>                 fec_reg_mpc5121(imask);
>                 ...
>         } else {
>                 fec_reg_mpc8xx(ievent);
>                 fec_reg_mpc8xx(imask);
>                 ...
>         }
> 
> Do you see a more clever solution to this problem? Nevertheless, the
> code could be improved by using "offsetof", I think.

Is there any chance of building a kernel that runs on both mpc8xx and
mpc5121? AFAIK, the 5121 is built on a 6xx core which is fundamentally
incompatible with 8xx due to different memory management etc.

Since this makes it all a compile-time decision, it should be solvable
with a very small number of carefully placed #ifdef in the header files
an no runtime detection at all.

Obviously this approach would not work for drivers that want to be portable
across different register layouts on otherwise compatible platforms.

	Arnd
