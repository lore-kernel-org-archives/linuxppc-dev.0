Return-Path: <lebon@lebon.org.ua>
Received: from b-mail.com.ua (b-mail.com.ua [195.68.202.242])
	by ozlabs.org (Postfix) with ESMTP id C0CD9B7B8D
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  6 Oct 2009 02:38:35 +1100 (EST)
Message-ID: <4ACA1300.6040105@lebon.org.ua>
Date: Mon, 05 Oct 2009 18:38:40 +0300
From: Mikhail Zolotaryov <lebon@lebon.org.ua>
MIME-Version: 1.0
To: Mike Nuss <mike@terascala.com>
Subject: Re: Regression detecting memory size on PPC440EPx
References: <2C7DE72B9BD00F44BAECA5B0CBB873955CADF2@hermes.terascala.com>
In-Reply-To: <2C7DE72B9BD00F44BAECA5B0CBB873955CADF2@hermes.terascala.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Mike,

Address width calculation is based on the DDR-controller configuration 
set by the bootloader. It would be helpful for further discussion if you 
could send DDR0_00..DDR0_44 register values and memory configuration 
used (no of banks, bank size, I/O width) to check calculations. Thanks.

P.S. Sequoia board also has DDR2 SDRAM from Micron.

Best regards,
Mikhail Zolotaryov


Mike Nuss wrote:
> There was a fix a while back called "Correct memory size calculation for
> Denali based boards" that corrected the data width detection in the 4xx
> bootwrapper.
>
> This seems to have had the unintended consequence of exposing another
> bug in the same code.  I have a board very similar to Sequoia, except
> that it uses a DDR2 DIMM module.  It uses a single 256MB DIMM.  After
> upgrading to the latest kernel, which includes the previously mentioned
> fix, U-Boot works fine, but the kernel detects 512MB instead, and of
> course, the kernel panics.
>
> The error seems to be in the calculation of row bits.  U-Boot's SPD
> detection says that the DIMM uses 13 bits, but I added some printf()s to
> the bootwrapper, and it is setting row to 14 instead.  I'm not too clear
> on how this code works; it calculates the row bits by subtracting the
> row from max_row, and maybe max_row is wrong?
>
> It looks like the data width bug canceled out this bug before, since
> these values end up changing the memory size by a factor of 2 (in
> opposite directions).
>
> Could someone with a better understanding of this code take a look?
>
> Thanks,
> Mike
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>   
