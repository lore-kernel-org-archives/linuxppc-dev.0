Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 34BF5DDEEA
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Nov 2007 08:51:53 +1100 (EST)
Date: Fri, 23 Nov 2007 00:51:21 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: [RFC/PATCH] powerpc: Move CPM command handling into the cpm
	drivers
Message-ID: <20071123005121.4d38d877@kernel.crashing.org>
In-Reply-To: <fa686aa40711221036n6438c252lde71cffdaff97ea9@mail.gmail.com>
References: <4745BB5F.6060002@scram.de>
	<fa686aa40711221036n6438c252lde71cffdaff97ea9@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 22 Nov 2007 11:36:29 -0700
Grant Likely wrote:

> > +int cpm_command(u32 command, u8 opcode)
> > +{
> > +       int i;
> > +
> > +       if (command & 0xffffff0f)
> > +               return -EINVAL;
> > +
> > +       out_be16(&cpmp->cp_cpcr, command | CPM_CR_FLG | (opcode <<
> > 8));
> > +       for (i = 0; i < MAX_CR_CMD_LOOPS; i++)
> > +               if ((in_be16(&cpmp->cp_cpcr) & CPM_CR_FLG) == 0)
> > +                       return 0;
> > +
> > +       printk(KERN_ERR "%s(): Not able to issue CPM command\n",
> > +               __FUNCTION__);
> > +       return -EIO;  
> 
> Do these need to be protected with a spin lock?
Even that might be not enough - we may have simultaneous call of this func in non-smp case...
I was thinking of some kind of refcount, so one that is going to issue CPM command, must do say pq_cpmp_get()
and another driver won't be able to mangle with cpcr while it's not done with previous request.

Yet I am not telling it was better the way it used to be - this approach looks okay but needs some efforts to defend against
deadlocks while we are at it.

-- 
Sincerely, Vitaly
