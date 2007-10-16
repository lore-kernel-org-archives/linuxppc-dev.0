Return-Path: <alan@akb.net>
Received: from wr-out-0506.google.com (wr-out-0506.google.com [64.233.184.229])
	by ozlabs.org (Postfix) with ESMTP id 9FAC4DDEED
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Oct 2007 07:38:23 +1000 (EST)
Received: by wr-out-0506.google.com with SMTP id 71so1227650wri
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 14:38:21 -0700 (PDT)
Message-ID: <bfa0697f0710161438y5472ced7y92ca981503a45e93@mail.gmail.com>
Date: Tue, 16 Oct 2007 15:38:20 -0600
From: "Alan Bennett" <embedded@akb.net>
Sender: alan@akb.net
To: "Scott Wood" <scottwood@freescale.com>
Subject: Re: Serial init / BRG
In-Reply-To: <47152065.9070403@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <bfa0697f0710160719r44099b19jbda55af2ef88e9f8@mail.gmail.com>
	<4714E763.5060901@freescale.com>
	<bfa0697f0710161114y6273af8fre045328b638a9de7@mail.gmail.com>
	<47152065.9070403@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The lockup is only the shell.  I echo from ttyCPM0 console and it
"locks" then I echo from an ssh session and the kernel messages still
output from the ttyCPM0 console.

NOTE: I found a severe issue that seems to have unlocked ttyCPM2.  BUT
ttyCPM1 still hangs.  (a while back, we commented out the out_be in
cpm_setbrg - oops (console debug left over))

with address / value in cpm_setbrg

echo test > /dev/ttyCPM1 # * note still hang *
CPM uart[1]:startup - port->irq 00000028
CPM uart[1]:startup - port->irq 40
cpm_setbrg:107 - brg:0 baud:9600
cpm_setbrg:108 - addr:e00119f0 value:00010140

echo test > /dev/ttyCPM2  * note doesn't hang *
CPM uart[2]:startup - port->irq 0000002b
CPM uart[2]:startup - port->irq 43
cpm_setbrg:107 - brg:3 baud:9600
cpm_setbrg:108 - addr:e00119fc value:00010140

On 10/16/07, Scott Wood <scottwood@freescale.com> wrote:
> Alan Bennett wrote:
> > I also verified that when I attempt to echo to the ports that I reach
> > the appropriate driver
> > i.e.
> > echo "hello" > /dev/ttyCPM1
> >    CPM uart[1]:startup - port->irq 40
> > echo "hello" > /dev/ttyCPM2
> >    CPM uart[2]:startup - port->irq 43
> > but brg's stay 0x0 and my shell's lock up something fierce.
>
> Hmm...  try putting a debugging printk in cpm_setbrg with the address
> and value it's writing.
>
> Is it just the shell that locks up, or the console (i.e. can you still
> get kernel messages)?
>
> > (note: my tree is still based off of one you provided a few weeks
> > back.  have the 82xx / ep8248e changes we went through been pushed
> > into linus' git tree?)
>
> It should all be in Linus's tree except the actual ep8248e file, which
> didn't make it this time around due to interdependencies on netdev.
> Note that there are some small device tree changes from the tree you're
> currently using (in particular, muram is now in a node of its own).
>
> -Scott
>
