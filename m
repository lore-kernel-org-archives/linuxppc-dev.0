Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18476.1203.459931.530585@cargo.ozlabs.ibm.com>
Date: Thu, 15 May 2008 19:38:59 +1000
From: Paul Mackerras <paulus@samba.org>
To: benh@kernel.crashing.org
Subject: Re: PS3: Fix memory hotplug
In-Reply-To: <1210834125.8297.80.camel@pasglop>
References: <4829C07A.4040407@am.sony.com> <1210834125.8297.80.camel@pasglop>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt writes:

> When you do an lmb_add you should probably also do an lmb_analyze to
> update the total memory count etc...
> 
> That leads to some interesting issues such as the LMB stuff wasn't
> really meant to be dynamically modified after boot, and thus the kernel
> has no locks in there. That can be an issue...
> 
> Paul, any thoughts here ? Should we add a lock ? That would mean being
> careful as the LMB stuff can be called very early, and spinlock wants
> things like PACA and possibly lockdep to be around.. 

Either that, or we give in and use iomem_resource to track where
system RAM is, as well as the other things in the physical address
space, like other architectures do...

Paul.
