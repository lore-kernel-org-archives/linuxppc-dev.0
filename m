Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 40D11B7CE9
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Jan 2010 20:37:06 +1100 (EST)
Message-ID: <4B59717F.6090200@grandegger.com>
Date: Fri, 22 Jan 2010 10:35:59 +0100
From: Wolfgang Grandegger <wg@grandegger.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: [net-next-2.6 PATCH 2/3] fs_enet: Add support for MPC512x to
	fs_enet driver
References: <1264039999-25731-3-git-send-email-agust@denx.de>	<20100121.012235.161201297.davem@davemloft.net>	<4B5871F2.9090005@grandegger.com>
	<20100121.180311.228791894.davem@davemloft.net>
In-Reply-To: <20100121.180311.228791894.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: wd@denx.de, dzu@denx.de, netdev@vger.kernel.org, linuxppc-dev@ozlabs.org,
	agust@denx.de, kosmo@semihalf.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Miller wrote:
> From: Wolfgang Grandegger <wg@grandegger.com>
> Date: Thu, 21 Jan 2010 16:25:38 +0100
> 
>> Do you see a more clever solution to this problem?
> 
> See how we handle this in the ESP scsi driver.  We have a set of
> defines for the register offsets, and a set of methods a chip driver
> implements for register accesses.
> 
> If the offsets differ, the register access method can translate the
> generic register offsets into whatever layout their implementation
> actually uses.

I think you speak about:

    void (*esp_write8)(struct esp *esp, u8 val, unsigned long reg);
    u8 (*esp_read8)(struct esp *esp, unsigned long reg);

But still we need to translate the *generic* offset (reg) into the real
offset, which requires a lookup/table to get it. For me this seems not
really more efficient and less transparent as it bends the offsets.

Wolfgang.
