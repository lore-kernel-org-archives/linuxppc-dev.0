Return-Path: <seanm@seanm.ca>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 1C4FADDDED
	for <linuxppc-dev@ozlabs.org>; Mon,  5 May 2008 14:40:26 +1000 (EST)
Date: Mon, 5 May 2008 00:40:23 -0400
From: Sean MacLennan <seanm@seanm.ca>
To: <benh@kernel.crashing.org>
Subject: Re: WARNING: mutexes are preferred for single holder semaphores
Message-ID: <20080505004023.05603b93@lappy.seanm.ca>
In-Reply-To: <1209958719.21644.32.camel@pasglop>
References: <20080504204104.7eea7618@lappy.seanm.ca>
	<1209958719.21644.32.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 05 May 2008 13:38:39 +1000
"Benjamin Herrenschmidt" <benh@kernel.crashing.org> wrote:

> Show us the code... It could be a bug in checkpatch or you using 
> the wrong functions somewhere ...

The change to DEFINE_MUTEX and changing up/down to
mutex_lock/mutex_unlock solved the problem.

The code is GPLed but not currently available on the net. It is
basically a little driver that registers a character device and
then passes out the minor numbers to the PIKA board drivers.

It was written to isolate all the character/sysfs code to one place
since we have five drivers, and many debug drivers, that use it.

If anybody is really interested, I can post it here. I doubt it will
ever be submitted to the mainline kernel however.

Cheers,
   Sean
