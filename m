Return-Path: <glikely@secretlab.ca>
MIME-Version: 1.0
In-Reply-To: <9e4733910901241720j157b7946t58792a9b2b21f1a3@mail.gmail.com>
References: <9e4733910901241720j157b7946t58792a9b2b21f1a3@mail.gmail.com>
Date: Sat, 24 Jan 2009 23:24:49 -0700
Message-ID: <fa686aa40901242224i3f4c8d3fkae964126aa69282e@mail.gmail.com>
Subject: Re: mpc5200 and PWM
From: Grant Likely <grant.likely@secretlab.ca>
To: Jon Smirl <jonsmirl@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jan 24, 2009 at 6:20 PM, Jon Smirl <jonsmirl@gmail.com> wrote:
> Is it possible to use Bestcomm with PWM to generate complex waveforms?
> For example change the frequency and duty cycle after each cycle? Has
> anyone tried doing this? I'd like to build a table of count/width
> pairs and then feed them to the PWM pin without taking an interrupt on
> each cycle.

I assume you're looking at using one of the GPT PWMs devices, correct?
 If so, the you probably cannot do what you want easily.  While you
may be able to writing a custom bestcomm task to write into the PWM
registers, the bestcomm engine isn't wired up to the PWM and so cannot
be triggered on PWM events.

However, the gpio blocks are wired up to the Bestcomm engine so they
can be used as requestors, so if you wired up the PWM output to one of
the GPIO inputs, then you may be able to do something with that.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
