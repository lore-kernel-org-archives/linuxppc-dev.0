Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 386EADDF9B
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Mar 2009 21:52:40 +1100 (EST)
Date: Mon, 16 Mar 2009 11:52:21 +0100
From: Gabriel Paubert <paubert@iram.es>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC] Moving toward smarter disabling of FPRs, VRs, and VSRs
	in the MSR
Message-ID: <20090316105221.GA21891@iram.es>
References: <1236975831.3137.61.camel@localhost.localdomain>
	<6F79BA93-346D-479F-BD63-D1D89B289D6F@kernel.crashing.org>
	<1236984351.25062.71.camel@pasglop>
	<FFBC9638-D064-43F9-B764-243739289710@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <FFBC9638-D064-43F9-B764-243739289710@kernel.crashing.org>
Cc: Will Schmidt <will_schmidt@vnet.ibm.com>,
	Steven Munroe <sjmunroe@us.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Mar 14, 2009 at 02:49:02PM +0100, Segher Boessenkool wrote:
>> Another option might be simply to say that if an app has used FP, VMX 
>> or
>> VSX -once-, then it's likely to do it again and just keep re-enabling
>> it :-)
>>
>> I'm serious here, do we know that many cases where these things are  
>> used
>> seldomly once in a while ?
>
> For FP, I believe many apps use it only sporadically.  But for VMX and 
> VSX,
> yeah, it might well be optimal to keep it enabled all the time.  Someone
> should do some profiling...

I concur. I have some apps who are mostly integer but from time to time
perform some statistics which are so much easier to write declaring
a few double variables. On the other hand when you start with vector
instructions, it often means that you are going to use them for a while.


This said, I'm not opposed to an heuristic like: if the app has used 
the FP/VMX/VSX registers systematically after having been scheduled a 
few times (2 for VMX/VSX, 5 for FP), load the corresponding registers 
on every schedule for the next n schedules, where n would be about 20
for VSX/VMX, and perhaps only 5 for FP. 

	Gabriel
