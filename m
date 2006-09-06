Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17662.17895.852128.729679@cargo.ozlabs.ibm.com>
Date: Wed, 6 Sep 2006 13:52:07 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: common flatdevtree code
In-Reply-To: <20060831184020.GA13494@mag.az.mvista.com>
References: <20060831184020.GA13494@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, hollisb@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark A. Greer writes:

> I'm doing some fairly massive rework to my patches so it'll take
> another day or two (plus 4 day weekend for me).  In the meantime,
> this is what I've done to your code.  :)

Any further progress on this?  I need an ft library for the prep
bootwrapper changes I'm planning.

I don't like the approach of doing a malloc for the whole blob every
time you make a property larger though.  I'm going to be adding quite
a few nodes and properties, potentially, and with a simple-minded
malloc (such as you get in a bootwrapper) it's likely to chew through
a lot of memory unnecessarily.  I would rather be able to start with
an existing blob and pull it apart once, add stuff to it, then put it
back together, doing a small number of mallocs in the process.

> I still plan on changing it a bit to use ft_next in a few more routines
> (e.g., ft_dump_blob).  ft_next has a clumsy interface but I like the fact

The interface might look nicer if we had a structure for the tag,
name, value and length.  Then there would only be one parameter
instead of the four you have at the moment.

Paul.
