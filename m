Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D0C5B1A0979
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 16:02:52 +1100 (AEDT)
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id ABA6E1402B7
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 16:02:52 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 13 Oct 2015 15:02:51 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id CBC1D2CE8056
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 16:02:48 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t9D52evq46858392
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 16:02:48 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9D52F3G017564
 for <linuxppc-dev@ozlabs.org>; Tue, 13 Oct 2015 16:02:16 +1100
Date: Tue, 13 Oct 2015 16:01:51 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH v2 3/8] powerpc/eeh: Force reset on fenced PHB
Message-ID: <20151013050151.GB28681@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1444276739-20372-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1444276739-20372-4-git-send-email-gwshan@linux.vnet.ibm.com>
 <871tcz4k78.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <871tcz4k78.fsf@gamma.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 13, 2015 at 12:43:23PM +1100, Daniel Axtens wrote:
>Gavin Shan <gwshan@linux.vnet.ibm.com> writes:
>
>> +	 *
>> +	 * When the PHB is fenced, we have to issue a reset to recover from
>> +	 * the error. Override the result if necessary to have partially
>> +	 * hotplug for this case.
>>  	 */
>>  	pr_info("EEH: Notify device drivers to shutdown\n");
>>  	eeh_pe_dev_traverse(pe, eeh_report_error, &result);
>> +	if ((pe->type & EEH_PE_PHB) &&
>> +	    result != PCI_ERS_RESULT_NONE &&
>> +	    result != PCI_ERS_RESULT_NEED_RESET)
>> +		result = PCI_ERS_RESULT_NEED_RESET;
>I think we shouldn't discard the DISCONNECT state. A driver could ask
>that the device be disconnected in the error_detected callback and we
>should probably honour that.
>

Not exactly, the improvement is limited to fenced PHB, not frozen PE case.
That's ok to discard DISCONNECT which forces all PHB's subordinate devices
to offline permanently, which isn't so reasonable.

This flag (DISCONNECT) has been there before the partial hotplug is
added. I think the flag can die now with partial hotplug support.

Thanks,
Gavin

>>  
>>  	/* Get the current PCI slot state. This can take a long time,
>>  	 * sometimes over 300 seconds for certain systems.
>> -- 
>> 2.1.0
>>
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
