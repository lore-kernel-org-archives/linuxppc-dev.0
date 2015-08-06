Return-Path: <pebolle@tiscali.nl>
Received: from lb1-smtp-cloud6.xs4all.net (lb1-smtp-cloud6.xs4all.net
 [194.109.24.24])
 (using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E6AF31A07E3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Aug 2015 09:09:53 +1000 (AEST)
Message-ID: <1438902589.26981.14.camel@tiscali.nl>
Subject: Re: windfarm: decrement client count when unregistering
From: Paul Bolle <pebolle@tiscali.nl>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Date: Fri, 07 Aug 2015 01:09:49 +0200
In-Reply-To: <1438899707.25241.29.camel@tiscali.nl>
References: <20150805041611.ACBD6140324@ozlabs.org>
 <1438899707.25241.29.camel@tiscali.nl>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On vr, 2015-08-07 at 00:21 +0200, Paul Bolle wrote:
> On wo, 2015-08-05 at 14:16 +1000, Michael Ellerman wrote:
> > I also get an oops when removing windfarm_lm75_sensor, so I suspect there are
> > gremlins in the module ref counting for windfarm.
> 
> (This I haven't (yet) looked into.)

And that might be, sort of, related. Because oops is probably triggered
by the, it seems, rather straightforward chain of events triggered by
unloading an I2C module. (So windfarm_lm75_sensor refcount must be
zero.) Which gets interesting at:

    wf_lm75_remove()
        wf_unregister_sensor(&wf_lm75_sensor->sens)
            wf_put_sensor(&wf_lm75_sensor->sens)
                module_put(wf_lm75_sensor->sens->ops->owner /* THIS_MODULE */)

And in windfarm_lm75_sensor we trigger this issue because in the
.probe() function there appears to be no corresponding call to
try_module_get() preventing unloading the module, as we saw in windfarm_
smu_sensors.

So module refcounting looks broken for both these modules in opposite
ways. Gremlins indeed.

Good luck!


Paul Bolle
