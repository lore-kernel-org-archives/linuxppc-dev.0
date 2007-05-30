Return-Path: <scottwood@freescale.com>
Message-ID: <465D9672.9060100@freescale.com>
Date: Wed, 30 May 2007 10:21:22 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Consolidate cuboot initialization code
References: <20070530020110.GC21955@localhost.localdomain>
	<465D9397.7000008@freescale.com>
	<20070530151236.GA14432@localhost.localdomain>
In-Reply-To: <20070530151236.GA14432@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Gibson wrote:
> On Wed, May 30, 2007 at 10:09:11AM -0500, Scott Wood wrote:
>>Is there any particular reason to not just do a direct call to 
>>cuboot_init, and move the memcpy and end-of-ram calculation there?  I'd 
>>rather avoid macros if possible.
> 
> Uh.. yeah.. because cuboot_init() doesn't know the size to memcpy(),
> because it doesn't have the right bd_t definition.

Ah, yes.  Don't mind me, it's still morning here... :-P

We could probably do away with the copy altogether, though, as u-boot 
puts the bd_t near the stack, which is exempted from the bootwrapper's 
heap with the 1MiB exclusion.

-Scott
