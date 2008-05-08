Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E944CDDF29
	for <linuxppc-dev@ozlabs.org>; Fri,  9 May 2008 00:16:19 +1000 (EST)
Message-Id: <5DD68A6B-45FD-4163-BDF5-356C70A00676@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Sam Ravnborg <sam@ravnborg.org>
In-Reply-To: <20080505204449.GA9446@uranus.ravnborg.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: How to link a .o with all modules
Date: Thu, 8 May 2008 09:16:10 -0500
References: <6C8AB345-2DA0-460D-B7C8-262463247DDE@kernel.crashing.org>
	<20080504192434.GA23752@uranus.ravnborg.org>
	<D346E2E4-26C3-482E-ABBF-AF1EE97E91CD@kernel.crashing.org>
	<20080505204449.GA9446@uranus.ravnborg.org>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	lkml List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 5, 2008, at 3:44 PM, Sam Ravnborg wrote:

>>>
>>>
>>> Let me know if this does address your question.
>>
>> The problem is MODPOST complains about undefined symbols:
>>
>>  MODPOST 24 modules
>> ERROR: "_restgpr_20_x" [net/key/af_key.ko] undefined!
>> ERROR: "_restgpr_25_x" [net/key/af_key.ko] undefined!
>> ERROR: "_restgpr_30_x" [net/key/af_key.ko] undefined!
>
> I need a bit more context to try to analyse this.
> Where did you expect _restgpr_20_x to be defined.
> If in vmlinux then were they present in the
> Module.symvers file?

No they aren't there since we I'm not EXPORT_SYMBOL() them.  Should I  
also be doing EXPORT_SYMBOL?

> If in the linked in .o file - could you
> see the symbols using objdump.

Yes.

readelf -a:

...
Symbol table '.symtab' contains 113 entries:
    Num:    Value  Size Type    Bind   Vis      Ndx Name
...
      5: 00000000     0 FUNC    GLOBAL DEFAULT    1 _savegpr_14
      6: 00000000     0 FUNC    GLOBAL DEFAULT    1 _save32gpr_14
...
>
>
> etc.
>
> Sorry - not much help right away.
>
> PS. Travelling - do not expect responses until the
> weekend.

np.
>
>
> 	Sam
