Subject: Re: Error when linking
To: manu@stapf.org
Date: Sat, 20 Oct 2001 11:47:09 -0700 (PDT)
Cc: k_fukui@highway.ne.jp ('Kaoru Fukui'),
	linuxppc-dev@lists.linuxppc.org
In-Reply-To: <001901c15984$23b05b80$f5732c0c@venice2> from "Emmanuel STAPF" at Oct 20, 2001 09:27:41 AM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20011020184710.1715A2B54A@marcus.pants.nu>
From: flar@pants.nu (Brad Boyer)
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I suspect the problem is that you're trying to call functions that the
linker is putting farther apart than can be referenced in a 24 bit
offset, which is the largest branch offset allowed with that type
of call. Would your final program be bigger than 16M? Any branch with
an offset more than 16M can't fit in a normal ppc branch instruction.
If possible, you should make your program smaller, but if that isn't
feasible, I seem to remember someone mentioning a way to make the
linker do calls with absolute, 32 bit addresses. I just don't remember
how to do it, and the ld manpages aren't the best in the world for
architecture specific stuff. This came up once before on the mailing
list, so you might try to search the archives.

	Brad Boyer
	flar@allandria.com

Emmanuel STAPF wrote:
>
>
> I should add that they occur only when I have my 1000 files. A similar
> project using those C function but smaller compiles without any problem.
>
> Any idea why and what are the possible solutions?
> Manu
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
