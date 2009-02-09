Return-Path: <remisbaima@gmail.com>
Received: from mail-bw0-f168.google.com (mail-bw0-f168.google.com
	[209.85.218.168]) by ozlabs.org (Postfix) with ESMTP id 31B71DDD1B
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Feb 2009 00:16:24 +1100 (EST)
Received: by bwz12 with SMTP id 12so2665996bwz.9
	for <linuxppc-dev@ozlabs.org>; Mon, 09 Feb 2009 05:16:21 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090209094014.GE7930@elte.hu>
References: <alpine.DEB.1.10.0902080118480.30802@gandalf.stny.rr.com>
	<20090209094014.GE7930@elte.hu>
Date: Mon, 9 Feb 2009 14:08:26 +0100
Message-ID: <9fe197cb0902090508v514808c9wc558c18b96ceaa6a@mail.gmail.com>
Subject: Re: [PATCH] ftrace, powerpc64: fix math to calculate offset in TOC
From: Remis Lima Baima <remisbaima@gmail.com>
To: Ingo Molnar <mingo@elte.hu>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Arnd Bergmann <arnd@arndb.de>, LKML <linux-kernel@vger.kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I have just tried the patch here and everything worked great!
Very well done.

On Mon, Feb 9, 2009 at 10:40 AM, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Steven Rostedt <rostedt@goodmis.org> wrote:
>
>>
>> Paul,
>>
>> I found the bug that was causing large modules to fail in setting
>> up dynamic ftrace. It wound up being a simple math error. To calculate
>> the offset in the TOC, I had used an OR, but the bottom half was
>> a signed extended short, and it should have been an addition.
>> The fix is in my tree below, as well as posted here.
>
> Looks like a .29 candidate?
>
>        Ingo

I agree. A functional ("out-of-the-box") dynamic-ftrace helps quite a lot ;-)


Regards,
Remis
