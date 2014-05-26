Return-Path: <sivasakthi7@outlook.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 161C31A0590
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 May 2014 08:20:41 +1000 (EST)
Received: from sam.nabble.com (sam.nabble.com [216.139.236.26])
 (using TLSv1 with cipher AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BB8611400A3
 for <linuxppc-dev@ozlabs.org>; Tue, 27 May 2014 08:20:40 +1000 (EST)
Received: from tom.nabble.com ([192.168.236.105])
 by sam.nabble.com with esmtp (Exim 4.72)
 (envelope-from <sivasakthi7@outlook.com>) id 1Wp3G1-00060p-0l
 for linuxppc-dev@ozlabs.org; Mon, 26 May 2014 15:20:37 -0700
Date: Mon, 26 May 2014 15:20:37 -0700 (PDT)
From: shiva7 <sivasakthi7@outlook.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <1401142837010-82686.post@n7.nabble.com>
In-Reply-To: <1400591218911-82485.post@n7.nabble.com>
References: <5167457E.1050205@genband.com>
 <1398170592855-81732.post@n7.nabble.com>
 <1398205896.1694.252.camel@snotra.buserror.net>
 <1398206224.1694.254.camel@snotra.buserror.net>
 <1400456291193-82408.post@n7.nabble.com>
 <1400521677.18239.16.camel@snotra.buserror.net>
 <1400591218911-82485.post@n7.nabble.com>
Subject: Re: questions on CONFIG_PPC_ADV_DEBUG_REGS, DBCR0_BRT, and
 DBCR0_ACTIVE_EVENTS
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

shiva7 wrote
> Thanks again Scott.
/
>> Any idea whether the DBCR0 BRT bit actually works(??), 
> 
>> Do you have reason to believe that it might not? 
/
> 
> I'm facing a strange problem which was not there on server processor. Let
> me try to give brief flow.
> 
> Server :
> 
> Set BE bit (thru system call or sigreturn) for specific thread -> for
> every branch -> trace exception -> Normal exception prolog
> (STD_EXCEPTION_COMMON) SRR0 and SRR1
> 
> Embedded/BOOKE:
> 
> Set DE & BRT bit (thru system call or sigreturn) for specific thread ->
> for every branch taken -> Debug exception -> DEBUG_DEBUG prolog ->
> return_dbg_except DSRR0 & DSRR1
> 
> In server case, able to capture the branches as expected, but wherein
> BOOKE though branch taken exception are generated, at the certain stage
> (mostly after turn on BRT & DE bit)  user process is deviated (not taking
> the same flow as like server) and leading to different
> corruption/unexpected behavior.
/
>> And also, anything special required for "server" family application code 
>> porting here ?? as because in server family the trace exception used to
>> viz 
>> NORMAL exception proglog and uses SRR0 and SRR1 but in this ISA/embedded 
>> case have dedicated DEBUG_DEBUG prolog and dedicated registers DSRR0 and 
>> DSRR1. 
> 
>> IIRC the branch taken mechanism does have different semantics than the 
>> equivalent mechanism on server.  You can find discussion of this in the 
>> archives. :-) 
/
> 
> Most of the discussions so far I have surfed are related to branch
> taken/fall through(not taken) semantics related. But, in general, if I
> have an application running on server where tracing was based on BE bit
> and same can run on e500mc with DE & BRT combination?
> 
> 
> Thanks In Advance.

Could someone help on this regard?




--
View this message in context: http://linuxppc.10917.n7.nabble.com/questions-on-CONFIG-PPC-ADV-DEBUG-REGS-DBCR0-BRT-and-DBCR0-ACTIVE-EVENTS-tp70147p82686.html
Sent from the linuxppc-dev mailing list archive at Nabble.com.
