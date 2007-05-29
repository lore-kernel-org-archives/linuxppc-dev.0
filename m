Return-Path: <pradyumna.sampath@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.183])
	by ozlabs.org (Postfix) with ESMTP id F2818DE03E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 May 2007 15:41:57 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id z74so3720797pyg
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 28 May 2007 22:41:56 -0700 (PDT)
Message-ID: <f87351060705282241k6af5f459nead66b61f54bc0e0@mail.gmail.com>
Date: Tue, 29 May 2007 11:11:55 +0530
From: "Pradyumna Sampath" <pradyumna.sampath@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: lite5200b, trouble with dtb
In-Reply-To: <f87351060705210453x206187f6y5e27c93c89979069@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <f87351060705210453x206187f6y5e27c93c89979069@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 5/21/07, Pradyumna Sampath <pradyumna.sampath@gmail.com> wrote:
> Hi everyone,
>
> Last time around (
> http://www.mail-archive.com/linuxppc-embedded@ozlabs.org/msg02602.html
> ) , I was trying to boot my lite5200 eval board with v2.6.20-rt3 and
> was advised to boot with the dtb files.
>
> This time around Im trying to boot my custom lite5200B board with the
> dtb file thats comes with the vanilla kernel and it hangs at the same
> point ( "Transferring control to linux (at address 00000000 ..." ).
<snip..>

Finally figured it out. As silly as it may sound it took me a while to
find out. My command line arguments were:

set bootargs console=ttyPSC0, 115200 ip=10.140.56.238
root=/dev/mtdblock0 rootfstype=jffs2 ; tftp 0x400000 uImage ; tftp
0x600000 lite5200b_22.dtb ; bootm 0x400000 - 0x600000 ;

The problem was

set bootargs console=ttyPSC0, 115200 ip=10.140.56.238
root=/dev/mtdblock0 ....<snip..>
                                           ^^
Yes, it was the space between the "," and "115200". Just putting it on
record so that other people dont spend as much time on fixing this
silly problem.

regards
Prady

-- 
htp://prady.livejournal.com
