Return-Path: <brueckner@linux.vnet.ibm.com>
Received: from mtagate7.de.ibm.com (mtagate7.de.ibm.com [195.212.17.167])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate7.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 31C35B7B8F
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2009 19:49:27 +1100 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate7.de.ibm.com (8.13.1/8.13.1) with ESMTP id n9G8nNFh019220
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2009 08:49:23 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.8/8.13.8/NCO v10.0) with
	ESMTP id n9G8nLAp3432606
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2009 10:49:23 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id n9G8nKJl016890
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Oct 2009 10:49:21 +0200
Date: Fri, 16 Oct 2009 10:49:24 +0200
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH] hvc_console: returning 0 from put_chars is not an error
Message-ID: <20091016084924.GB4234@linux.vnet.ibm.com>
References: <1255557226-4403-1-git-send-email-timur@freescale.com>
	<200910152041.26646.borntraeger@de.ibm.com>
	<4AD770A9.6070509@freescale.com>
	<200910152126.28024.borntraeger@de.ibm.com>
	<4AD778E6.7020806@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4AD778E6.7020806@freescale.com>
Cc: linuxppc-dev@ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	Christian Borntraeger <borntraeger@de.ibm.com>,
	brueckner@linux.vnet.ibm.com, Timur Tabi <timur@freescale.com>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 15, 2009 at 02:32:54PM -0500, Scott Wood wrote:
> Christian Borntraeger wrote:
>> About the backends, there are some that spin until the text is 
>> delivered (e.g. virtio) , others can drop (e.g. iucv is a connection 
>> oriented protocol and it will (and has to) drop if there is no 
>> connection). 
>
> Sure, dropping due to not having a connection makes sense.  That's  
> different from merely being busy.  Can the iucv code tell the difference  
> between those two states?

The states are handled by the hvc_iucv itself:
If the hvc_iucv code has a connection established, terminal or console data
are queued and sent to the peer. If the state is disconnected, terminal and
console data is discarded internally.

- Hendrik
