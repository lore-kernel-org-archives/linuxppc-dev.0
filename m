Return-Path: <gerickson@nuovations.com>
Received: from relay01.pair.com (relay01.pair.com [209.68.5.15])
	by ozlabs.org (Postfix) with SMTP id D7208DDEEE
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Dec 2008 10:44:16 +1100 (EST)
Date: Thu, 18 Dec 2008 15:43:54 -0800
Subject: Re: [PATCH v2] Add PPC/4xx "ibm,sdram-4xx-ddr2" EDAC MC Driver
From: Grant Erickson <gerickson@nuovations.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Message-ID: <C570203A.138A0%gerickson@nuovations.com>
In-Reply-To: <C56FE0DE.1387F%gerickson@nuovations.com>
Mime-version: 1.0
Content-type: text/plain;
	charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org, bluesmoke-devel@lists.sourceforge.net,
	dougthompson@xmission.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/18/08 11:13 AM, Grant Erickson wrote:
> On 12/18/08 9:56 AM, Josh Boyer wrote:
>> So, I am not an expert at the EDAC subsystem.  Just looking at the
>> number of functions that get call from this interrupt handler, I'm
>> wondering if a significant amount of time could be spent here.  With
>> all the message building and such, it seems like it could be error
>> prone.
> 
> The message building functions are really best-effort, straight-through, so
> there should be little room if any for error-proneness. Though, snprintf
> contained therein is fairly costly as functions go.
> 
>> Do you have an idea of the duration of one of these events?  Could
>> this schedule a work queue to handle it outside of the hard IRQ
>> context?
> 
> I'll take some measurements for the worst case message length time. I
> certainly thought about a work queue; however, my gut feeling was that it
> wasn't warranted.
> 
> Stay tuned for measurement data.

In general, correctable and uncorrectable ECC errors in and of themselves
should be rare events. So, by extension, the generation of these ECC error
messages should be rare as well.

When one of these CE or UE ECC events occurs, the time required to build the
driver-unique log message is as shown below for a run of ~300 forced CEs at
at a processor frequency of 400 MHz:

                Ticks       Time / us
     --------------------------------
     Minimum     4150           10.38
     Maximum     9075           22.69
     Mean        8024           20.06
     Median      8297           20.74
     Mode        8869           22.17
     Std. Dev.    864            2.16
     --------------------------------

Regards,

Grant
