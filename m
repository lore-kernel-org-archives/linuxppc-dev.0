Return-Path: <geoffrey.levand@am.sony.com>
Received: from mgw2.sony.co.jp (MGW2.Sony.CO.JP [137.153.0.14])
	by ozlabs.org (Postfix) with ESMTP id A7E0167CE2
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Nov 2006 01:25:48 +1100 (EST)
Received: from mail5.sony.co.jp (localhost [127.0.0.1])
	by mail5.sony.co.jp (R8/Sony) with ESMTP id kAEEPksa023727
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 23:25:46 +0900 (JST)
Received: from mailgw01.scei.sony.co.jp (mailgw01.scei.sony.co.jp [43.27.73.7])
	by mail5.sony.co.jp (R8/Sony) with SMTP id kAEEPkdI023708
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Nov 2006 23:25:46 +0900 (JST)
Message-ID: <4559D1C9.60702@am.sony.com>
Date: Tue, 14 Nov 2006 06:25:13 -0800
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 7/16] powerpc: add support for ps3 platform
References: <4554DACB.8060809@am.sony.com> <20061110152310.7419ef3e@pb15>
In-Reply-To: <20061110152310.7419ef3e@pb15>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Olof Johansson wrote:
>> +config PS3PF_HTAB_SIZE
>> +	depends on PS3PF
>> +	int "PS3 Platform pagetable size"
>> +	range 18 20
>> +	default 20
>> +	help
>> +	  This option is only for experts who may have the desire to fine
>> +	  tune the pagetable size on their system.  The value here is
>> +	  expressed as the log2 of the page table size.  Valid values are
>> +	  18, 19, and 20, corresponding to 256KB, 512KB and 1MB respectively.
>> +
>> +	  If unsure, choose the default (20) with the confidence that your
>> +	  system will have optimal runtime performance.
> 
> Wouldn't it be more understandable if you had a "small/medium/large"
> memory config options (that in itself sets the values) instead of
> having people pick numbers?

In general you'll want the max, 1MB, which is actually small.  This
was intended for tuning embedded systems where it is expected the
user understands the ramifications of pagetable size selection
and the log2 values will be familiar.

The trouble I see with having the options you suggest is that if a
future version of the HV supports different sizes, then how do you
map those into your "small/medium/large" scheme?  With numbers it
falls out naturally.

-Geoff
