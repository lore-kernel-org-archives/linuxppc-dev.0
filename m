Return-Path: <chris.friesen@genband.com>
Received: from exprod7og102.obsmtp.com (exprod7og102.obsmtp.com [64.18.2.157])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 790B72C009D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Apr 2013 09:29:15 +1100 (EST)
Message-ID: <515DFD87.7050303@genband.com>
Date: Thu, 04 Apr 2013 16:24:07 -0600
From: Chris Friesen <chris.friesen@genband.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: weird elf header issues, is it binutils or my linker script?
References: <51545BF3.2090204@genband.com>
 <1AEA14BF-7AFA-43F4-8082-F0D3031C60A8@kernel.crashing.org>
 <5159A180.90000@genband.com>
 <BFFF4F77-FA45-40B6-8836-EFF3A23A9480@kernel.crashing.org>
In-Reply-To: <BFFF4F77-FA45-40B6-8836-EFF3A23A9480@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/02/2013 09:07 AM, Segher Boessenkool wrote:

>> What I don't understand is where the "/lib/ld.so.1" string is coming
>> from and how the length gets set to the invalid value.
>
> It comes from the .interp input sections, i.e. the .interp sections in
> the .o files you linked together. Perhaps you have more than one of
> those?

It turns out that the problem was in the linker script.  The linker 
script was originally written for an older binutils.  With the newly 
compiled object files there were some sections that were not explicitly 
specified in the linker script so they were added automatically to the 
interpreter section, bumping up the length.

A new linker script with explicit mention of those sections made the 
interpreter section look as expected.

Chris
