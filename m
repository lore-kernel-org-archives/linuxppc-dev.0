Message-ID: <3E96BC29.1020903@adtran.com>
Date: Fri, 11 Apr 2003 07:59:21 -0500
From: Ron Flory <ron.flory@adtran.com>
MIME-Version: 1.0
To: Steven Scholz <steven.scholz@imc-berlin.de>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: parse error before `{', stray '\' in program
References: <20030411072503.64755C5877@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:
> In message <3E96684D.7000601@imc-berlin.de> you wrote:
>
>>Good you please post the URL to the list if you find one!
>>I am facing this problem from time to time ...
>>
>>Does anyone know if the ppc_8xx-gcc 2.95.4 from DENX ELDK has this
>>patch applied?
>
>
> No, it has not, and will not.
>
> I see no sense in a modification that supports violations  of  the  C
> standard.

  especially when its so easy to cleanup text files by piping them
through 'tr':

    cat "$src_file" | tr -d \\015 > "$tmp_file"
    mv -f $tmp_file $src_file

  which removes those funky MsDos carriage returns.

(depending on your shell, you may be able to skip the tmp_file above)

  Just write a small shell-script that iterates through your source
files, applying this filter.


  Like you, I also develop on several platforms.  I find it convenient
to add a new 'fix' target to the makefiles, then run the above filter
on all source and header files in the project.

   <import file from MsDos/windoze>
   make fix           # with implied 'make clean'
   make

  works great, on lots and lots of projects...

ron


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
