Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from outbound4-sin-R.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 04EA8DDE10
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Mar 2007 10:21:23 +1000 (EST)
Received: from outbound4-sin.bigfish.com (localhost.localdomain [127.0.0.1])
	by outbound4-sin-R.bigfish.com (Postfix) with ESMTP id CB96BAF85AF
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Mar 2007 00:10:18 +0000 (UTC)
Received: from mail27-sin-R.bigfish.com (unknown [10.3.252.3])
	by outbound4-sin.bigfish.com (Postfix) with ESMTP id EE9152824E1
	for <linuxppc-dev@ozlabs.org>; Sun, 25 Mar 2007 00:06:08 +0000 (UTC)
Message-ID: <4605B861.9060006@am.sony.com>
Date: Sat, 24 Mar 2007 16:46:41 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH 8/9] ps3: cleanup ps3fb before clearing HPTE
References: <Pine.LNX.4.62.0701251825390.14799@pademelon.sonytel.be>	<Pine.LNX.4.62.0701251851160.24610@pademelon.sonytel.be>
	<20070126031438.GH18537@lst.de>
In-Reply-To: <20070126031438.GH18537@lst.de>
Content-Type: text/plain; charset=UTF-8
Cc: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>,
	Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph Hellwig wrote:
>>>  static void ps3_hpte_clear(void)
>>  {
>> +
>> +#ifdef CONFIG_FB_PS3
>> +	ps3fb_cleanup();
>> +#endif
> 
> And well, adding framebuffer calls into the mmu code is rather fucked.
> This at least needs a big comment explaning the hypervisor braindamage
> that is responsible for this in colourfull language.

Sorry for such a late reply, but I'm now doing the kexec code and see
why it was put here (by the original author).  It is so you will have
debugging output until the very last possible moment during a kexec
shutdown.

The real problem is really that this routine (and the corresponding ppc_md
variable) are inappropriately named.  In the general case all that is left
to do is to call ppc_md.hpte_clear_all, but for ps3 we also want to do the
framebuffer shutdown here, so something like this should be better:

-static void ps3_hpte_clear(void)
+static void ps3_kexec_final(void)

-	ppc_md.hpte_clear_all = ps3_hpte_clear;
+	ppc_md.hpte_clear_all = ps3_kexec_final;

-Geoff
