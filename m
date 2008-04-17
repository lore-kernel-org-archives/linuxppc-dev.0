Return-Path: <cbouatmailru@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.186])
	by ozlabs.org (Postfix) with ESMTP id 416F6DE32C
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 08:35:08 +1000 (EST)
Received: by fk-out-0910.google.com with SMTP id z22so381036fkz.9
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Apr 2008 15:35:05 -0700 (PDT)
Date: Fri, 18 Apr 2008 02:35:00 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 3/5] [POWERPC] QE: split par_io_config_pin()
Message-ID: <20080417223500.GA16022@zarina>
References: <20080417192656.GA19107@polina.dev.rtsoft.ru>
	<20080417192850.GC28286@polina.dev.rtsoft.ru>
	<2F36BD63-363C-4BA6-AA42-8002A09FD937@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <2F36BD63-363C-4BA6-AA42-8002A09FD937@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
Reply-To: cbouatmailru@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 17, 2008 at 04:53:34PM -0500, Kumar Gala wrote:
>
> On Apr 17, 2008, at 2:28 PM, Anton Vorontsov wrote:
>> This patch splits par_io_config_pin so we can use it with GPIO LIB  
>> API.
>>
>> Also add a comment regarding #ifdef CONFIG_PPC_85xx being legacy.
>
> legacy to what?

If we'll ever manage to remove pio fixups from the device tree, we then
can safely remove whole par_io_of_config(struct device_node *np) along
with par_io_*(u8 port, ...), which only needs this #ifdef CONFIG_PPC_85xx.
Users (so far only mpc8323e-rdb IIRC) of par_io_data_set(u8 port, ...)
will be converted to GPIO API.

And since device tree fixups considered legacy, I marked this code as
legacy too. Am I wrong here?

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
