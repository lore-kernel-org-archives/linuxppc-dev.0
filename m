Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4C55EDDE29
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  5 Sep 2007 04:37:54 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l84IbpCD000795
	for <linuxppc-embedded@ozlabs.org>; Tue, 4 Sep 2007 14:37:51 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l84Ibk77241810
	for <linuxppc-embedded@ozlabs.org>; Tue, 4 Sep 2007 12:37:47 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l84Ibjlv009852
	for <linuxppc-embedded@ozlabs.org>; Tue, 4 Sep 2007 12:37:45 -0600
Date: Tue, 4 Sep 2007 13:37:43 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: disable interrput under ppc?
Message-ID: <20070904133743.67a7a651@weaponx.rchland.ibm.com>
In-Reply-To: <20070904182433.GD18280@ld0162-tx32.am.freescale.net>
References: <200709041044.16525.wangbj@lzu.edu.cn>
	<20070904182433.GD18280@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, 4 Sep 2007 13:24:33 -0500
Scott Wood <scottwood@freescale.com> wrote:

> On Tue, Sep 04, 2007 at 10:44:14AM +0800, Wang, Baojun wrote:
> > hi, list
> > 
> >   How can I disable interrput like `cli' in x86?
> 
> local_irq_disable().
> 
> > I want the following code freeze the box but it doesn't, $MSR is
> > altered however the box is still alive, how can I freeze the box like
> > `cli' in x86? Thanks very much!
> 
> Disabling interrupts doesn't freeze the machine by itself -- it depends
> on what you do afterwards, which you didn't show.

If you're using a BOOKE variant, there is a way to use the DBCR0
register to set debug wait enable or something to basically hang the
CPU until something external clears that bit.  But why you would want
to do that, I have no idea.

josh
