Return-Path: <jan.dakinevich@gmail.com>
Received: from mail-lf0-x241.google.com (mail-lf0-x241.google.com
 [IPv6:2a00:1450:4010:c07::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vn0rP0DDpzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 02:54:45 +1100 (AEDT)
Received: by mail-lf0-x241.google.com with SMTP id r36so10695071lfi.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 08:54:44 -0700 (PDT)
Subject: Re: [PATCH] tty: hvc: don't allocate a buffer for console print on
 stack
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <1487364165-21882-1-git-send-email-jan.dakinevich@gmail.com>
 <20170317050930.GB28075@kroah.com>
Cc: Jiri Slaby <jslaby@suse.com>, Peter Hurley <peter@hurleysoftware.com>,
 Dan Carpenter <dan.carpenter@oracle.com>, Arnd Bergmann <arnd@arndb.de>,
 Amit Shah <amit@kernel.org>, virtualization@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Jan Dakinevich <jan.dakinevich@gmail.com>
Message-ID: <18f113d4-9c37-0114-d637-3720ad093722@gmail.com>
Date: Mon, 20 Mar 2017 18:55:15 +0300
MIME-Version: 1.0
In-Reply-To: <20170317050930.GB28075@kroah.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> You shouldn't use 'static' data either, that's not always guaranteed to
> be DMA-able, right?

I naively thought all 'static' data was linked into .data and the
section was always kmapped.

> What about allocating it dynamically?  That's the correct thing to do.

Yep, the solution was more welcomed and happened earlier:
https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=c4baad50297d84bde1a7ad45e50c73adae4a2192

On 03/17/2017 08:09 AM, Greg Kroah-Hartman wrote:
> On Fri, Feb 17, 2017 at 11:42:45PM +0300, Jan Dakinevich wrote:
>> The buffer is used by virtio console driver as DMA buffer. Since v4.9
>> (if VMAP_STACK is enabled) we shouldn't use the stack for DMA.
> 
> You shouldn't use 'static' data either, that's not always guaranteed to
> be DMA-able, right?
> 
>>
>> Signed-off-by: Jan Dakinevich <jan.dakinevich@gmail.com>
>> ---
>>  drivers/tty/hvc/hvc_console.c | 7 ++++++-
>>  1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/tty/hvc/hvc_console.c b/drivers/tty/hvc/hvc_console.c
>> index 9b5c0fb..1ce6aaf 100644
>> --- a/drivers/tty/hvc/hvc_console.c
>> +++ b/drivers/tty/hvc/hvc_console.c
>> @@ -143,10 +143,15 @@ static struct hvc_struct *hvc_get_by_index(int index)
>>  static void hvc_console_print(struct console *co, const char *b,
>>  			      unsigned count)
>>  {
>> -	char c[N_OUTBUF] __ALIGNED__;
>>  	unsigned i = 0, n = 0;
>>  	int r, donecr = 0, index = co->index;
>>  
>> +	/*
>> +	 * Access to the buffer is serialized by console_sem in caller code from
>> +	 * kernel/printk/printk.c
>> +	 */
>> +	static char c[N_OUTBUF] __ALIGNED__;
> 
> What about allocating it dynamically?  That's the correct thing to do.
> 
> thanks,
> 
> greg k-h
> 

-- 
Best regards
Jan Dakinevich
