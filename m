Return-Path: <olh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4F2CB679F0
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 19:17:37 +1100 (EST)
Received: from Relay2.suse.de (mail2.suse.de [195.135.221.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mx2.suse.de (Postfix) with ESMTP id B57A02177F
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Dec 2006 09:17:32 +0100 (CET)
Date: Thu, 7 Dec 2006 09:17:32 +0100
From: Olaf Hering <olh@suse.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: 2.6.19 cannot find root partition
Message-ID: <20061207081732.GA29848@suse.de>
References: <20061206211630.GB27857@krispykreme>
	<20061206222213.GA17446@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20061206222213.GA17446@localhost.localdomain>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Dec 07, David Gibson wrote:

> Yeah, I had this problem on paulus' old PReP machine - I had to
> manually zap the AIX magic number to get it to see the perfectly good
> partitions.

Something like this in aix_label_present should do it, beside
echo > /dev/sda

        struct partition *pt = (struct partition *) (p + 0x1be);
        int slot;
        for (slot = 1; slot <= 4; slot++, pt++) {
                if (pt->sys_ind == LINUX_SWAP_PARTITION ||
                        pt->sys_ind == LINUX_RAID_PARTITION ||
                        pt->sys_ind == 0x83 ||
                        pt->sys_ind == 0x8e ||
                        is_extended_partition(pt))
                        return 0;
        }                                                                                                                                                            
