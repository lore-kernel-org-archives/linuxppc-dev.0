Return-Path: <dhlii@dlasys.net>
Received: from outbound-mail-27.bluehost.com (outbound-mail-27.bluehost.com
	[69.89.17.193]) by ozlabs.org (Postfix) with SMTP id 9D62CDDE18
	for <linuxppc-dev@ozlabs.org>; Mon, 11 May 2009 16:38:47 +1000 (EST)
Message-ID: <4A07C664.6040609@dlasys.net>
Date: Mon, 11 May 2009 02:32:04 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: device trees.
References: <4A0457BC.3040408@dlasys.net>
	<fa686aa40905091351k140c64a0w27eb44908218814@mail.gmail.com>
	<1242007203.7767.28.camel@concordia>
	<fa686aa40905102108l5c964893y2dfb84763e13511@mail.gmail.com>
In-Reply-To: <fa686aa40905102108l5c964893y2dfb84763e13511@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

    I will have to look at the code referenced below,

    But my objective is not to address partial reconfiguration at this time.
    At Pico we have come to the conclusion that as it is currently done
partial reconfiguration has extremely limited use.
    We are actively looking at other techniques as well as different
FPGA technology to impliment usable equivalents.

    But partial reconfiguration is not the only way to encounter a
dynamic environment.
    A typical pico system has multiple bit files and multiple
executables stored in its flash file system.
    Power up and soft resets might each run through a different sequence
of bit files and executables.
    
    My issue is that post 2.6.26 unless I can dynamically create the
device tree inside our monitor/bootloader
    we must at minimum have a different device tree for each bitfile, or
worse if we wrap the device tree into the executable,
    a different linux executable for each bit file.
    We are very actively headed in the opposite direction. It is my/our
intention to have a single linux executable that works accross
    everyone of our cards and everyone of our bitfiles.
   
   


Grant Likely wrote:
> On Sun, May 10, 2009 at 8:00 PM, Michael Ellerman
> <michael@ellerman.id.au> wrote:
>   
>> On Sat, 2009-05-09 at 14:51 -0600, Grant Likely wrote:
>>     
>>> On Fri, May 8, 2009 at 10:03 AM, David H. Lynch Jr. <dhlii@dlasys.net> wrote:
>>>       
>>>>    Is there an example somewhere that shows building a device tree on
>>>> the fly ?
>>>>
>>>>    As our products move forward it becomes increasingly clear that
>>>> static configurations are not going to work.
>>>>         
>>> To use device tree with partial reconfiguration would require rework
>>> to the device tree infrastructure to prune and graft portions of the
>>> device tree.  I think it is possible, but it is non-trivial to get
>>> working.
>>>       
>> arch/powerpc/platforms/pseries/reconfig.c
>>
>> Not pretty, but it does more or less what you're talking about. Would
>> need some work to get it going on !pseries obviously.
>>     
>
> Heh, I didn't even know this existed.  :-)
>
> Thinking about this more, it seems to me that the tricky bit would be
> figuring out how to drop all references to a node before it is pruned
> from the tree.  of_platform_devices would probably be the easiest
> because the bus could walked before pruning the node, but there are
> also references on the i2c, spi and mdio busses that must be dealt
> with appropriately.
>
> g.
>
>   


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
