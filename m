Return-Path: <patrick.huesmann@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.207])
	by ozlabs.org (Postfix) with ESMTP id D37A167A70
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 18 Mar 2005 02:42:43 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 37so276594wra
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Mar 2005 07:42:42 -0800 (PST)
Message-ID: <93579fec05031707422039934e@mail.gmail.com>
Date: Thu, 17 Mar 2005 16:42:38 +0100
From: Patrick Huesmann <patrick.huesmann@gmail.com>
To: "Robert P. J. Day" <rpjday@mindspring.com>
In-Reply-To: <Pine.LNX.4.61.0503171011220.20335@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <Pine.LNX.4.61.0503161125560.5095@localhost.localdomain>
	<93579fec05031706597355371c@mail.gmail.com>
	<Pine.LNX.4.61.0503171011220.20335@localhost.localdomain>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: looking for a model for building CRAMFS(?)-based system
Reply-To: Patrick Huesmann <patrick.huesmann@gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

On Thu, 17 Mar 2005 10:14:41 -0500 (EST), Robert P. J. Day
<rpjday@mindspring.com> wrote:
> On Thu, 17 Mar 2005, Patrick Huesmann wrote:
> > When updating the initrd, the only thing necessary is a
> > eraseall /dev/mtdX
> > cat initrd.gz > /dev/mtdX
> 
> now this is the sticky part.  imagine this system out in the field,
> where you need to make an update to something in the initrd in the
> root filesystem.

If you know in advance what small parts you will want to change
(perhaps your main application, /var/www or whatever), you can use an
additional small partition, that holds only these files, mount it
somewhere in your rootfs, and you won't have to upload the whole
initrd when updating.

> one technique would be to, of couse, download an entirely new
> initrd.gz and reflash (hoping no one pulls the plug as you're doing
> it), as you describe above.

Power failure is not the only scenario when field updates go wrong.
We once had a stressed-out customer who uploaded the "readme" file to
the zImage partition. (Of course, you can prevent that with sanity
checks),
When something like this happens, it's always good to have a fallback
option, like a small bootloader that is NEVER updated, and can still
be used to flash the rest of the system over slow RS232 or whatever.

Regards,
Patrick
