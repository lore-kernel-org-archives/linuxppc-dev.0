Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f201.google.com (mail-yw0-f201.google.com
	[209.85.211.201]) by ozlabs.org (Postfix) with ESMTP id 12AA0B7C31
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 12 Jan 2010 09:59:09 +1100 (EST)
Received: by ywh39 with SMTP id 39so20456455ywh.17
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 11 Jan 2010 14:59:07 -0800 (PST)
MIME-Version: 1.0
Sender: glikely@secretlab.ca
In-Reply-To: <20100109110104.GA20100@x200>
References: <1262830753.577814.127040702434.1.gpush@pororo>
	<20100109110104.GA20100@x200>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Mon, 11 Jan 2010 15:58:47 -0700
Message-ID: <fa686aa41001111458g5975e055ga4c7cd830fff1906@mail.gmail.com>
Subject: Re: [PATCH] proc_devtree: fix THIS_MODULE without module.h
To: Alexey Dobriyan <adobriyan@gmail.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Jeremy Kerr <jeremy.kerr@canonical.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jan 9, 2010 at 4:01 AM, Alexey Dobriyan <adobriyan@gmail.com> wrote:
> On Thu, Jan 07, 2010 at 01:19:13PM +1100, Jeremy Kerr wrote:
>> Commit e22f628395432b967f2f505858c64450f7835365 introduced a build
>> breakage for ARM devtree work: the THIS_MODULE macro was added, but we
>> don't have module.h
>>
>> This change adds the necessary #include to get THIS_MODULE defined.
>> While we could just replace it with NULL (PROC_FS is a bool, not a
>> tristate), using THIS_MODULE will prevent unexpected breakage if we
>> ever do compile this as a module.
>
> I'd say, remove .owner line.
> It definitely not needed in non-modular code.

No.  Jeremy's fix is the better one.  Having the .owner line doesn't
cost anything and it is better to have it populated; even if only as
an example.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
