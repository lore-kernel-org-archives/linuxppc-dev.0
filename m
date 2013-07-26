Return-Path: <paulus@ozlabs.org>
Date: Fri, 26 Jul 2013 13:19:50 +1000
From: Paul Mackerras <paulus@samba.org>
To: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH 4/5] cpuidle/ppc: CPU goes tickless if there are no
 arch-specific constraints
Message-ID: <20130726031950.GA6438@iris.ozlabs.ibm.com>
References: <20130725090016.12500.28888.stgit@preeti.in.ibm.com>
 <20130725090302.12500.42998.stgit@preeti.in.ibm.com>
 <20130725133044.GA7400@somewhere>
 <51F1E15B.3050106@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <51F1E15B.3050106@linux.vnet.ibm.com>
Cc: deepthi@linux.vnet.ibm.com, shangw@linux.vnet.ibm.com, arnd@arndb.de,
 linux-pm@vger.kernel.org, geoff@infradead.org,
 Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org,
 rostedt@goodmis.org, rjw@sisk.pl, paul.gortmaker@windriver.com,
 john.stultz@linaro.org, srivatsa.bhat@linux.vnet.ibm.com,
 schwidefsky@de.ibm.com, tglx@linutronix.de, paulmck@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, chenhui.zhao@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jul 26, 2013 at 08:09:23AM +0530, Preeti U Murthy wrote:
> Hi Frederic,
> 
> On 07/25/2013 07:00 PM, Frederic Weisbecker wrote:
> > Hi Preeti,
> > 
> > I'm not exactly sure why you can't enter the broadcast CPU in dynticks idle mode.
> > I read in the previous patch that's because in dynticks idle mode the broadcast
> > CPU deactivates its lapic so it doesn't receive the IPI. But may be I misunderstood.
> > Anyway that's not good for powersaving.
> 
> Let me elaborate. The CPUs in deep idle states have their lapics
> deactivated. This means the next timer event which would typically have
> been taken care of by a lapic firing at the appropriate moment does not
> get taken care of in deep idle states, due to the lapic being switched off.

I really don't think it's helpful to use the term "lapic" in
connection with Power systems.  There is nothing that is called a
"lapic" in a Power machine.  The nearest equivalent of the LAPIC on
x86 machines is the ICP, the interrupt-controller presentation
element, of which there is one per CPU thread.

However, I don't believe the ICP gets disabled in deep sleep modes.
What does get disabled is the "decrementer", which is a register that
normally counts down (at 512MHz) and generates an exception when it is
negative.  The decrementer *is* part of the CPU core, unlike the ICP.
That's why we can still get IPIs but not timer interrupts.

Please reword your patch description to not use the term "lapic",
which is not defined in the Power context and is therefore just
causing confusion.

Paul.
