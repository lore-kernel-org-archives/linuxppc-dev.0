Subject: Re: SystemACE, but I'm not a V2Pro
From: Jeff Angielski <jeff@theptrgroup.com>
To: Stephen Williams <612dlag102@sneakemail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <10183-36126@sneakemail.com>
References: <10183-36126@sneakemail.com>
Content-Type: text/plain
Message-Id: <1079968679.20420.13.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 22 Mar 2004 10:17:59 -0500
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Stephen,

Here is the simple change that what worked for me:

static void
xsysace_restart(char *cmd)
{
        XSysAce_ResetCfg(&SysAce);

        /* also call the machdep restart */
        if( old_restart )
                old_restart(cmd);

        /* Wait for reset. */
        for (;;) ;
}


Jeff


On Sun, 2004-03-21 at 21:00, Stephen Williams wrote:
> I'm successfully using the existing System ACE adapter driver
> to mount my compact flash devices, and that's great. But I'm
> getting some baggage I don't want. Specifically, in adapter.c
> the xsysace_init function replaces the ppc_md.restart function
> with xsysace_restart, which breaks reboot on my PPC405GPr based
> board.
>
> The brute force method is for me to #ifdef out that bit of
> code with something like "#ifndef CONFIG_JSE" (my board is
> a JSE board) but that seems klunky.
>
> It seems to me there may be others who have SystemACE boards
> without V2Pro chips. Would it be safe and reasonable for me
> to use the CONFIG_VIRTEX_II_PRO config define to ifdef that
> bit of code *in*?
>
> (I'm asking because I'd like to integrate my board support
> into the main tree someday, so I want a generally clean patch.)
>
> --
> Steve Williams                "The woods are lovely, dark and deep.
> steve at XXXXXXXXXX           But I have promises to keep,
> http://www.XXXXXXXXXX         and lines to code before I sleep,
> http://www.picturel.com       And lines to code before I sleep."
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
