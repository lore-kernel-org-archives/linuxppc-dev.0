Message-ID: <39522AB6.230ED909@embeddededge.com>
Date: Thu, 22 Jun 2000 11:03:18 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: diekema_jon <diekema@bucks.si.com>
CC: linuxppc-embedded@lists.linuxppc.org, dan_malek@mvista.com, all@cideas.com
Subject: Re: Missing cpm_install_handler/cpm_free_handler on the MPC8260 port
References: <m1357B4-001SyaC@bucks>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


diekema_jon wrote:

>         It appears that the interrupt controller on the MPC8260 is a bit
>         different from the MPC8xx.


That is why these functions are not needed on the 8260.  On the 8xx,
the CPM is a second level interrupt controller from the PowerPC core.
That is, the CPM was one interrupt vector from the SIU core, and the
CPM further multiplexed all interrupts from its devices.

On the 8260, all CPM devices are unique interrupts from the SIU core,
so they use the "standard" internal interrupt controller functions.  I
don't know what a "CPM interrupt" function would do on the 8260, other
than be a single line of code that calls the SIU interrupt function
with exactly the same parameters.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
