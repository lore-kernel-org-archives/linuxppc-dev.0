In-Reply-To: <20040331100318.B17284@home.com>
References: <49B568CB-832A-11D8-9FF0-000A95A07384@sands-edge.com> <20040331164423.GA417@gate.ebshome.net> <20040331100318.B17284@home.com>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <9B139B02-834D-11D8-9FF0-000A95A07384@sands-edge.com>
Cc: linuxppc-dev@lists.linuxppc.org
From: John Whitney <johnw@sands-edge.com>
Subject: Re: Proposed changes to io.h
Date: Wed, 31 Mar 2004 14:57:14 -0500
To: Matt Porter <mporter@kernel.crashing.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I wonder will it work on 4xx CPUs which don't have floating point unit?
>
> #ifndef CONFIG_PPC_CLASSIC_FPU?
>

I don't see this in arch/ppc/Kconfig (or anywhere else) in the 2.6.5
kernel which I am using (or in arch/ppc/config.in, for 2.4.25).  I can
certainly create a patch to Kconfig that does this, or I could check
for PPC_FEATURE_HAS_FPU in cur_cpu_spec[0]->cpu_user_features  in
__raw_readq/writeq():

unsigned long long __raw_readq (int addr)
{
   if (cur_cpu_spec[0]->cpu_user_features & PPC_FEATURE_HAS_FPU) {
     ...
   } else {
     return *((volatile unsigned long long *) addr);
}

or somesuch.  This would work as long as the compiler doesn't have a
snitfit with FP instructions, even if the processor can't use them...

Which would the maintainers prefer?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
