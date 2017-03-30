Return-Path: <srs0=6f2n=3h=linux.vnet.ibm.com=mahesh@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vtwdd3kLnzDqKm
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 18:05:57 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3vtwdd2wTLz8svk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Mar 2017 18:05:57 +1100 (AEDT)
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3vtwdb5Xl9z9ryZ
 for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2017 18:05:55 +1100 (AEDT)
Received: from pps.filterd (m0098416.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2U73ig8164192
 for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2017 03:05:51 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29gfk2htkt-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2017 03:05:51 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 30 Mar 2017 17:05:48 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2U75bC849283218
 for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2017 18:05:45 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2U75CXZ011297
 for <linuxppc-dev@ozlabs.org>; Thu, 30 Mar 2017 18:05:12 +1100
Subject: Re: [PATCH 2/2] powerpc/book3s: Display task info for MCE error in
 user mode.
To: Nicholas Piggin <npiggin@gmail.com>
References: <149070869902.18309.14355142133222424050.stgit@jupiter.in.ibm.com>
 <149070872807.18309.16273606222489045198.stgit@jupiter.in.ibm.com>
 <20170330100947.74c7a76d@roar.ozlabs.ibm.com>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Michael Ellerman <mpe@ellerman.id.au>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 30 Mar 2017 12:34:55 +0530
MIME-Version: 1.0
In-Reply-To: <20170330100947.74c7a76d@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <15565296-4e1e-18bf-b369-dc5821e266c0@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/30/2017 05:39 AM, Nicholas Piggin wrote:
> On Tue, 28 Mar 2017 19:15:28 +0530
> Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com> wrote:
> 
>> From: Mahesh Salgaonkar <mahesh@linux.vnet.ibm.com>
>>
>> For MCE that hit while in use mode MSR(HV=1,PR=1), print the task info on the
>> console MCE error log. This will help to identify application that stumbled
>> upon MCE error.
> 
> I think you may still want these details for a task currently in
> kernel. How about something like if (!in_interrupt()) {

We queue up the MCE event to delay the printing of recovered MCEs in the
kernel. We may have to hook up the task details in the MCE event.

> 
> 
>> @@ -311,8 +312,13 @@ void machine_check_print_event_info(struct machine_check_event *evt)
>>  	printk("%s%s Machine check interrupt [%s]\n", level, sevstr,
>>  	       evt->disposition == MCE_DISPOSITION_RECOVERED ?
>>  	       "Recovered" : "Not recovered");
>> -	printk("%s  NIP [%016llx]: %pS\n", level, evt->srr0,
>> +	if (user_mode) {
>> +		printk("%s  NIP: [%016llx] PID: %d Comm: %s\n", level,
>> +				evt->srr0, current->pid, current->comm);
>> +	} else {
>> +		printk("%s  NIP [%016llx]: %pS\n", level, evt->srr0,
>>  							(void *)evt->srr0);
>> +	}
>>  	printk("%s  Initiator: %s\n", level,
>>  	       evt->initiator == MCE_INITIATOR_CPU ? "CPU" : "Unknown");
>>  	switch (evt->error_type) {
> 
