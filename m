Return-Path: <glikely@secretlab.ca>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.29])
	by ozlabs.org (Postfix) with ESMTP id 740C9DDF5D
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 15:46:27 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so1639570yxg.39
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 20:46:25 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <200901212213.04001.jbe@pengutronix.de>
References: <20090121205506.31232.27908.stgit@localhost.localdomain>
	<20090121205512.31232.99373.stgit@localhost.localdomain>
	<200901212213.04001.jbe@pengutronix.de>
Date: Wed, 21 Jan 2009 21:46:25 -0700
Message-ID: <fa686aa40901212046h3e9ef7ceyb996c80c21e65c07@mail.gmail.com>
Subject: Re: [PATCH 2/8] powerpc/5200: Stop using device_type and port-number
	properties
From: Grant Likely <grant.likely@secretlab.ca>
To: Juergen Beisert <jbe@pengutronix.de>
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

On Wed, Jan 21, 2009 at 2:13 PM, Juergen Beisert <jbe@pengutronix.de> wrote:
> Am Mittwoch, 21. Januar 2009 21:55 schrieb Grant Likely:
>> [...]
>> The whole 'port-number' scheme for assigning numbers to PSC uarts was
>> always rather half baked and just adds complexity.  Remove it from the
>> driver.  After this patch is applied, PSC UART numbers are simply
>> assigned from the order they are found in the device tree (just like
>> all the other devices).  Userspace can query sysfs to determine what
>> ttyPSC number is assigned to each PSC instance.
>
> Arrghh, the next time we have to touch every oftree of our supported boards to
> keep it work. Does it ever end?

This change will not break existing .dts files.  If it does, then it
is a bug.  Existing boards will still boot.

It may change the ttyPSC numbers that the kernel assigns at boot time.
 If so then, yes, it may require config changes in /etc.

The reason I want to do this is that trying to manipulate the
assignments using port-number resulted in a lot of confusion and it
had the driver trying to do policy stuff (especially considering
port-number is completely arbitrary and doesn't even have any relation
to the physical PSC numbering from the 5200 user manual).  I want to
get away from that entirely and go with a strict probe order
enumeration of PSC ports since there are more reliable methods to map
physical ports to ttyPSC numbers (assuming it really needs to be
detected at runtime instead of statically configured).

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
