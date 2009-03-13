Return-Path: <jwboyer@gmail.com>
Received: from qw-out-2122.google.com (qw-out-2122.google.com [74.125.92.26])
	by ozlabs.org (Postfix) with ESMTP id 61856DE155
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Mar 2009 10:52:48 +1100 (EST)
Received: by qw-out-2122.google.com with SMTP id 3so1342579qwe.15
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Mar 2009 16:52:46 -0700 (PDT)
Date: Fri, 13 Mar 2009 19:52:18 -0400
From: Josh Boyer <jwboyer@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RFC] Moving toward smarter disabling of FPRs, VRs, and VSRs
	in the MSR
Message-ID: <20090313235218.GA2799@yoda.jdub.homelinux.org>
References: <1236975831.3137.61.camel@localhost.localdomain>
	<6F79BA93-346D-479F-BD63-D1D89B289D6F@kernel.crashing.org>
	<1236984351.25062.71.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1236984351.25062.71.camel@pasglop>
Cc: linuxppc-dev@ozlabs.org, Will Schmidt <will_schmidt@vnet.ibm.com>,
	Steven Munroe <sjmunroe@us.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Mar 14, 2009 at 09:45:51AM +1100, Benjamin Herrenschmidt wrote:
>
>> If these applications are aware they are heavy users (of FP, VMX, VSX)  
>> can we not use a sysctl()?  Doing so wouldn't be that difficult.
>> 
>> I think trying to do something based on a runtime heuristic sounds a  
>> bit iffy.
>
>Another option might be simply to say that if an app has used FP, VMX or
>VSX -once-, then it's likely to do it again and just keep re-enabling
>it :-)
>
>I'm serious here, do we know that many cases where these things are used
>seldomly once in a while ?

This seems reasonable to me.

>An if we do, maybe then a simple counter in the task struct... if the
>app re-enables it more than a few consecutive switches, then make it
>stick. I have the feeling that would work out reasonably well.

Gee.  That sounds like a runtime heuristic :)

josh
