Return-Path: <roel.kluin@gmail.com>
Received: from ug-out-1314.google.com (ug-out-1314.google.com [66.249.92.168])
	by ozlabs.org (Postfix) with ESMTP id 95FA6DDDED
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Nov 2008 00:27:23 +1100 (EST)
Received: by ug-out-1314.google.com with SMTP id 17so2211368ugm.14
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Nov 2008 05:27:21 -0800 (PST)
Message-ID: <49314334.6060609@gmail.com>
Date: Sat, 29 Nov 2008 08:27:16 -0500
From: roel kluin <roel.kluin@gmail.com>
MIME-Version: 1.0
To: Andreas Schwab <schwab@suse.de>
Subject: Re: powerpc: hv{cs,
	si}_close() both unsigned hp->count and hvcsd->open_count
	cannot be negative
References: <4931201D.7060701@gmail.com> <jey6z24rqw.fsf@sykes.suse.de>
In-Reply-To: <jey6z24rqw.fsf@sykes.suse.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Andreas Schwab wrote:
> roel kluin <roel.kluin@gmail.com> writes:
> 
>> -	if (--hvcsd->open_count == 0) {
>> +	if (hvcsd->open_count == 1) {
>> +		hvcsd->open_count--;
> 
> This is not the same.

I think you're missing that I also decrement if (hvcsd->open_count > 1)
If not, please elaborate.

> 
>> -	if (--hp->count == 0) {
>> +	if (hp->count == 1) {
>> +		hp->count--;
> 
> Likewise.

Same here.

Roel
