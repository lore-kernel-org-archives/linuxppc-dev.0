Return-Path: <matt@ozlabs.org>
Message-ID: <4C0700FD.6060303@ozlabs.org>
Date: Thu, 03 Jun 2010 11:10:21 +1000
From: Matt Evans <matt@ozlabs.org>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: Emulate most Book I instructions
	in	emulate_step()
References: <20100602112903.GB30149@brick.ozlabs.ibm.com>	<09904F7B-6319-45FA-ADC4-757A2AD239AB@kernel.crashing.org>
	<20100603004758.GA19618@brick.ozlabs.ibm.com>
In-Reply-To: <20100603004758.GA19618@brick.ozlabs.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, "K.Prasad" <prasad@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> [snip]
> The second alternative -- emulating the lwarx/stwcx and all the
> instructions in between -- sounds complicated but turns out to be
> pretty straightforward in fact, since the code for each instruction is
> pretty small, easy to verify that it's correct, and has little
> interaction with other code.

Easy to verify -- visually or logically?

Having had a little experience with interpreters 'invisibly' operating behind the scenes I am all for very rigorous testing of these things.  I have lost at least four of my nine lives to incorrect flag values, odd data problems and hideous heisenbugs etc. of such interpreters.  Looked at another way, you'd be surprised how much one can break in an interpreter and still successfully run various programs.

Presumably your first pass is completely correct already, but I'm thinking that if any future changes are made to it 
it would be good to include test code/modes alongside the interpreter so others can check alterations.  E.g. include the "run user program interpreted" test switch patch, or even better compare the interpreted state to real hardware execution.  There are other more directed test strategies (e.g. handwritten tests, random code) but these would be a good start.


Cheers,


Matt
